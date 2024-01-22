// ??: rx do once, then it can assert irq output? (i think it does!)
// CPU get irq (rx directly gave), wait some cycles, then wb_adr == RX_DATA & rx_fifo pop

module ctrl(
    input wire        rst_n,
    input wire        clk,
    input wire        i_wb_valid,
    input wire [31:0] i_wb_adr,
    input wire        i_wb_we,
    input wire [31:0] i_wb_dat,
    input wire [3:0]  i_wb_sel,
    output reg        o_wb_ack,
    output reg [31:0] o_wb_dat,
    // RX
    input wire [7:0]  i_rx,
    input wire        i_irq, // got irq, then rx_fifo push.(dont assert ctrl_irq, not same signal.)
    input wire        i_rx_busy,
    input wire        i_frame_err,
    output reg        o_rx_finish, // need to see fifo is_full, but don't care irq.(irq is generate when fifo have items)
    // RX FIFO
    output reg        o_rx_push, // when irq comes, push into rx_fifo
    output reg        o_rx_pop,  // when wbs_adr ask for data (wbs_valid && wbs_adr==RX_DATA)
    input wire        i_rx_full,
    input wire        i_rx_empty, // useless, since we check irq
    // TX
    output reg [7:0]  o_tx, // give data from CPU to tx_fifo
    input wire        i_tx_start_clear,
    input wire        i_tx_busy,
    output reg        o_tx_start, // call tx to do.
    // TX FIFO
    output reg        o_tx_push,
    output reg        o_tx_pop,  // this must be at the end of tx_busy.(since fifo output should hold, cant change)
    input wire        i_tx_full,
    input wire        i_tx_empty
);

// Declare the UART memory mapped registers address
localparam RX_DATA  = 32'h3000_0000;

localparam TX_DATA	= 32'h3000_0004;

localparam STAT_REG = 32'h3000_0008;

//+------+-------+-------+-------+-------+-------+-------+-------+-------+-------+-------+
//|RX_DATA |  RESERVERD  |                        DATA BITS                              |
//|        |    31-8     |  7    |  6    |  5    |  4    |  3    |  2    |  1    |  0    |
//+------+-------+-------+-------+-------+-------+-------+-------+-------+-------+-------+
//|TX_DATA |  RESERVERD  |                        DATA BITS                              |
//|        |    31-8     |  7    |  6    |  5    |  4    |  3    |  2    |  1    |  0    |
//+------+-------+-------+-------+-------+-------+-------+-------+-------+-------+-------+-------+-------+
//|STAT_REG|  RESERVERD  |  Frame Err  |  Overrun Err  |  Tx_full  |  Tx_empty  |  Rx_full  |  Rx_empty |
//|        |    31-6     |  5          |  4            |  3        |  2         |  1        |  0        |
//+------+-------+-------+-------+-------+-------+-------+-------+-------+-------+-------+-------+-------+

//reg [31:0] rx_buffer;
reg [31:0] tx_buffer;
reg [31:0] stat_reg;    
reg tx_start_local;
reg [1:0] rx_push_state;
parameter RX_WAIT_IRQ    = 2'b00;
parameter RX_WAIT_RXFULL = 2'b01;
parameter RX_PUSH        = 2'b10;
parameter RX_DONE        = 2'b11;
reg rx_pop_state;
parameter RX_WAIT_CPU    = 1'b0;
parameter RX_POP         = 1'b1;

reg [1:0] tx_push_state;

// stat_reg for CPU ask
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        stat_reg <= 32'h0000_0005;
    end else begin
        if(i_wb_valid && !i_wb_we)begin
            if(i_wb_adr==STAT_REG)
                stat_reg[5:4] <= 2'b00;
        end

        if(i_tx_busy)
            stat_reg[3:2] <= 2'b10;
        else
            stat_reg[3:2] <= 2'b01;

        if(i_frame_err && i_rx_busy)
            stat_reg[5] <= 1'b1;
        else if(i_irq && !stat_reg[1] && !i_frame_err)
            stat_reg[1:0] <= 2'b10;
        //else if(i_rx_busy && stat_reg[1:0]==2'b10)
            //stat_reg[4] <= 1'b1;
        else if((i_wb_valid && i_wb_adr==RX_DATA && !i_wb_we && stat_reg[1:0]==2'b10) || i_frame_err)
            stat_reg[1:0] <= 2'b01;
    end
end

// RX push
always @(posedge clk or negedge rst_n)begin
    if(!rst_n) begin 
        rx_push_state <= 0;
        o_rx_push <= 0;
        o_rx_finish <= 0;
    end
    else begin 
        case(rx_push_state)
            RX_WAIT_IRQ   : begin // wait rx give irq
                rx_push_state <= (i_irq)? RX_WAIT_RXFULL : RX_WAIT_IRQ;
                o_rx_finish <= 0;
            end
            RX_WAIT_RXFULL: begin // rx data is ready, but rx_fifo is full
                rx_push_state <= (!i_rx_full)? RX_PUSH : RX_WAIT_RXFULL;
            end
            RX_PUSH       : begin
                rx_push_state <= RX_DONE;
                o_rx_push <= 1;
            end 
            RX_DONE       : begin
                rx_push_state <= RX_WAIT_IRQ;
                o_rx_push <= 0;
                o_rx_finish <= 1;
            end 
            default: rx_push_state <= rx_push_state;
        endcase
    end
end

// RX pop
always @(posedge clk or negedge rst_n)begin
    if(!rst_n) begin 
        rx_pop_state <= 0;
        o_rx_pop <= 0;
    end
    else begin 
        case(rx_pop_state)
            RX_WAIT_CPU : begin
                rx_pop_state <= (i_wb_valid && !i_wb_we && i_wb_adr==RX_DATA)? RX_POP : RX_WAIT_CPU; // wait CPU
                o_rx_pop <= 0;
            end
            RX_POP      : begin
                rx_pop_state <= RX_WAIT_CPU;
                o_rx_pop <= 1;
            end
            default: rx_pop_state <= rx_pop_state;
        endcase
    end
end

// CPU ask
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        o_wb_dat <= 32'h00000000;
    end else begin
        if(i_wb_valid && !i_wb_we)begin
            case(i_wb_adr)
                RX_DATA:begin         // CPU (wishbone) want data
                    //o_wb_dat <= rx_buffer; // buffer data prepare for CPU (wishbone)
                    o_wb_dat <= i_rx; // buffer data prepare for CPU (wishbone)
                end
                STAT_REG:begin
                    o_wb_dat <= stat_reg; // CPU will ask whether it can get data or not (ready or not).
                    // o_wb_dat <= {stat_reg[31:2], 2'b01}; // test fifo empty
                end
                default:begin 
                    o_wb_dat <= 32'h00000000;
                end
            endcase
        end
    end
end

// TX
always@(posedge clk or negedge rst_n)begin
    if(!rst_n || i_tx_start_clear)begin
        tx_buffer <= 32'h00000000;
        tx_start_local <= 1'b0;
    end else begin
        if(i_wb_valid && i_wb_we && i_wb_adr==TX_DATA && !i_tx_busy)begin
            tx_buffer <= i_wb_dat;
            tx_start_local <= 1'b1;
        end
    end
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n || i_tx_start_clear)begin
        o_tx <= 8'b0;
        o_tx_start <= 1'b0;
    end else begin
        o_tx <= tx_buffer[7:0];
        o_tx_start <= tx_start_local;
    end
end

// WB ack
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        o_wb_ack <= 1'b0;
    end else begin
        if(i_wb_valid)  
            o_wb_ack <= 1'b1;
        else            
            o_wb_ack <= 1'b0;
    end
end

endmodule
