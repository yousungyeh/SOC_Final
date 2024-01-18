module uart #(
  parameter BAUD_RATE = 9600 
)(
`ifdef USE_POWER_PINS
    inout vccd1,	// User area 1 1.8V supply
    inout vssd1,	// User area 1 digital ground
`endif
  // Wishbone Slave ports (WB MI A)
  input wire    wb_clk_i,
  input wire    wb_rst_i,
  input wire    wbs_stb_i,
  input wire    wbs_cyc_i,
  input wire    wbs_we_i,
  input wire    [3:0] wbs_sel_i,
  input wire    [31:0] wbs_dat_i,
  input wire    [31:0] wbs_adr_i,
  output wire   wbs_ack_o,
  output wire   [31:0] wbs_dat_o,

  // IO ports
  input  [`MPRJ_IO_PADS-1:0] io_in, // The io_in[..] signals are from the pad to the user project and are always
									// active unless the pad has been configured with the "input disable" bit set.
  output [`MPRJ_IO_PADS-1:0] io_out,// The io_out[..] signals are from the user project to the pad.
  output [`MPRJ_IO_PADS-1:0] io_oeb,// The io_oeb[..] signals are from the user project to the pad cell.  This
									// controls the direction of the pad when in bidirectional mode.  When set to
									// value zero, the pad direction is output and the value of io_out[..] appears
									// on the pad.  When set to value one, the pad direction is input and the pad
									// output buffer is disabled.

  // irq
  output [2:0] user_irq
);

  // UART 
  wire  tx;
  wire  rx;

  assign io_oeb[6] = 1'b0; // Set mprj_io_31 to output
  assign io_oeb[5] = 1'b1; // Set mprj_io_30 to input
  assign io_out[6] = tx;	// Connect mprj_io_6 to tx
  assign rx = io_in[5];	// Connect mprj_io_5 to rx

  // irq
  wire irq;
  assign user_irq = {2'b00,ctrl_irq};	// Use USER_IRQ_0
  
  wire wb_valid;
  // 32'h3000_0000 memory regions of user project  
  assign wb_valid = (wbs_adr_i[31:8] == 32'h3000_00) ? wbs_cyc_i && wbs_stb_i : 1'b0;

  wire [31:0] clk_div;
  assign clk_div = 40000000 / BAUD_RATE;

  //rx
  wire [7:0] rx_data; 
  wire rx_finish;
  wire rx_busy;
  wire rx_finished;	// for testbench

  // rx fifo
  wire [7:0] rx_fifo_data;
  wire [2:0] rx_fifo_count;

  // tx fifo
  wire [7:0] tx_fifo_data; 
  wire [2:0] tx_fifo_count; 
  wire tx_push;
  
  //tx
  wire [7:0] tx_data;
  wire tx_start_clear;
  wire tx_busy;
  wire frame_err;

  // ctrl
  wire [1:0]crtl_stat;
  reg  [1:0]crtl_stat_p;
  wire tx_fifo_start;
  reg [1:0]tx_fifo_start_lag;

  // tx start
  reg tx_start;
  always @(posedge wb_clk_i or posedge wb_rst_i) begin
    if(wb_rst_i) begin
      tx_start <= 1'b0;
    end else begin
      if(tx_fifo_count > 0 && !tx_busy && !tx_start_clear)
        tx_start <= 1'b1;
      else
        tx_start <= 1'b0;
    end
  end
  
  // tx_fifo_start -> tx push
  assign tx_push = (tx_fifo_start_lag == 2'b10)? 1'b1 : 1'b0;
  always @(posedge wb_clk_i or posedge wb_rst_i) begin
    if(wb_rst_i) begin
      tx_fifo_start_lag <= 2'b00;
    end else begin
      tx_fifo_start_lag[1] <= tx_fifo_start;
      tx_fifo_start_lag[0] <= tx_fifo_start_lag[1];
    end
  end

  // ctrl irq
  reg ctrl_irq;
  reg [1:0] ctrl_irq_valid;

  always @(posedge wb_clk_i or posedge wb_rst_i) begin
    if(wb_rst_i) crtl_stat_p <= 2'b01;	//tx empty
    else crtl_stat_p <= crtl_stat;
  end
  
  always @(posedge wb_clk_i or posedge wb_rst_i) begin
    if(wb_rst_i) ctrl_irq_valid <= 2'b11;
    else if(crtl_stat == 2'b01 && crtl_stat_p == 2'b10) ctrl_irq_valid <= 2'b01;
    else if(ctrl_irq_valid == 2'b01) ctrl_irq_valid <= 2'b10;
    else if(ctrl_irq_valid == 2'b10) ctrl_irq_valid <= 2'b11;
    else if(rx_fifo_count > 0 && ctrl_irq_valid == 2'b11) ctrl_irq_valid <= 2'b00;
    else ctrl_irq_valid <= ctrl_irq_valid;
  end

  always @(posedge wb_clk_i or posedge wb_rst_i) begin
    if(wb_rst_i) ctrl_irq <= 1'b0;
    else if(rx_fifo_count > 0 && ctrl_irq_valid == 2'b11) begin
    //else if(rx_fifo_count > 0 && !tx_busy) begin
    	ctrl_irq <= 1'b1;
    end
    else ctrl_irq <= 1'b0;
  end

  uart_receive receive(
    .rst_n      (~wb_rst_i  ),
    .clk        (wb_clk_i   ),
    .clk_div    (clk_div    ),
    .rx         (rx         ),
    .rx_finish  (rx_finished),
    
    .rx_data    (rx_data    ),
    .irq        (irq        ),
    .frame_err  (frame_err  ),
    .busy       (rx_busy)
  );

  fifo rx_fifo(
    .clk	(wb_clk_i   ),
    .rst	(~wb_rst_i  ),
    .i_data	(rx_data    ),
    .push	(irq        ),
    .pop	(rx_finish  ),

    .o_data	(rx_fifo_data),
    .count	(rx_fifo_count)
  );
  
  ctrl ctrl(
	.rst_n		(~wb_rst_i	),
	.clk		(wb_clk_i	),
        .i_wb_valid	(wb_valid	),
	.i_wb_adr	(wbs_adr_i	),
	.i_wb_we	(wbs_we_i	),
	.i_wb_dat	(wbs_dat_i	),
	.i_wb_sel	(wbs_sel_i	),
	.o_wb_ack	(wbs_ack_o	),
	.o_wb_dat 	(wbs_dat_o	),
  	.i_rx		(rx_fifo_data	),
  	.i_irq    	(ctrl_irq  	),
  	.i_frame_err  	(frame_err	),
  	.i_rx_busy    	(1'b0  	),
	.o_rx_finish  	(rx_finish	),
	.o_tx		(tx_data	),
	.i_tx_start_clear(tx_push	), 
  	.i_tx_busy    	(tx_busy  	),
	.o_tx_start	(tx_fifo_start ),
  	.stat_reg	(crtl_stat	) 
  );
  
  fifo tx_fifo(
    .clk	(wb_clk_i   ),
    .rst	(~wb_rst_i  ),
    .i_data	(tx_data    ),
    .push	(tx_push        ),
    .pop	(tx_start_clear ),

    .o_data	(tx_fifo_data	),
    .count	(tx_fifo_count	)
  );

  uart_transmission transmission(
    .clk        (wb_clk_i   ),
    .rst_n      (~wb_rst_i  ),    
    .clk_div    (clk_div    ),
    .tx_start   (tx_start	),
    .tx_data    (tx_fifo_data	),    
    
    .tx         (tx         		),
    .clear_req  (tx_start_clear	),
    .busy       (tx_busy    		)
  );
  
endmodule
