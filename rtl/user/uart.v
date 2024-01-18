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
  wire irq, ctrl_irq;
  //assign user_irq = {2'b00,irq};	// Use USER_IRQ_0
  assign user_irq = {2'b00,ctrl_irq};	// Use USER_IRQ_0

  // CSR
  wire [7:0] rx_data; 
  wire irq_en;
  wire rx_finish;
  wire rx_busy;
  wire [7:0] tx_data;
  wire tx_start_clear;
  wire tx_start;
  wire tx_busy;
  wire wb_valid;
  wire frame_err;
  
  // 32'h3000_0000 memory regions of user project  
  assign wb_valid = (wbs_adr_i[31:8] == 32'h3000_00) ? wbs_cyc_i && wbs_stb_i : 1'b0;

  wire [31:0] clk_div;
  assign clk_div = 40000000 / BAUD_RATE;
  
  // FIFO wire
  wire tx_push, tx_pop, tx_full, tx_empty;
  wire rx_push, rx_pop, rx_full, rx_empty;
  wire [31:0] tx_fifo_i_data, tx_fifo_o_data;
  wire [31:0] rx_fifo_i_data, rx_fifo_o_data;
  
  assign rx_fifo_i_data = rx_data;
  assign tx_data = tx_fifo_o_data;

  uart_receive receive(
    .rst_n      (~wb_rst_i  ),
    .clk        (wb_clk_i   ),
    .clk_div    (clk_div    ),
    .rx         (rx         ),
    .rx_data    (rx_data    ),
    .rx_finish  (rx_finish  ),	// data receive finish
    .irq        (irq        ),
    .frame_err  (frame_err  ),
    .busy       (rx_busy    )
  );
  
  fifo rx_fifo(
  	.clk		(wb_clk_i),
  	.rst_n		(~wb_rst_i),
  	.push		(rx_push),
  	.pop		(rx_pop),
  	.i_data	(rx_fifo_i_data),
  	.o_data	(rx_fifo_o_data),
  	.is_full	(rx_full),
  	.is_empty	(rx_empty)
  );

  uart_transmission transmission(
    .rst_n      (~wb_rst_i  ),
    .clk        (wb_clk_i   ),
    .clk_div    (clk_div    ),
    .tx         (tx         ),
    .tx_data    (tx_data    ),
    .clear_req  (tx_start_clear), 	// clear transmission request
    .tx_start   (tx_start   ),
    .busy       (tx_busy    )
  );
  
  fifo tx_fifo(
  	.clk		(wb_clk_i),
  	.rst_n		(~wb_rst_i),
  	.push		(tx_push),
  	.pop		(tx_pop),
  	.i_data	(tx_fifo_i_data),
  	.o_data	(tx_fifo_o_data),
  	.is_full	(tx_full),
  	.is_empty	(tx_empty)
  );
  
  ctrl ctrl(
	.rst_n		(~wb_rst_i),
	.clk		(wb_clk_i),
  	.i_wb_valid	(wb_valid),
	.i_wb_adr	(wbs_adr_i),
	.i_wb_we	(wbs_we_i),
	.i_wb_dat	(wbs_dat_i),
	.i_wb_sel	(wbs_sel_i),
	.o_wb_ack	(wbs_ack_o),
	.o_wb_dat	(wbs_dat_o),
	
	.i_rx		(rx_fifo_o_data), //
  	.i_irq		(irq),
  	.o_ctrl_irq	(ctrl_irq),
  	.i_frame_err	(frame_err),
  	.i_rx_busy	(rx_busy),
	.o_rx_finish	(rx_finish),
	
	.o_tx		(tx_fifo_i_data), //
	.i_tx_start_clear(tx_start_clear), 
  	.i_tx_busy	(tx_busy),
	.o_tx_start	(tx_start),
	
        .o_tx_push	(tx_push),
        .o_tx_pop	(tx_pop),
        .i_tx_full	(tx_full),
        .i_tx_empty	(tx_empty),
     
        .o_rx_push	(rx_push),
        .o_rx_pop	(rx_pop),
        .i_rx_full	(rx_full),
        .i_rx_empty	(rx_empty)
  );

endmodule
