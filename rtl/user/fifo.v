module fifo #(
	parameter fifo_depth = 4,
	parameter addr_size = 2, // this must follow fifo_depth
	parameter data_size = 8
)(
	input clk,
	input rst_n,
	input push, // only need 1 clk
	input pop,  // only need 1 clk
	input [data_size-1:0] i_data,
	output wire [data_size-1:0] o_data,
	output wire is_full,
	output wire is_empty
);
	reg [data_size-1:0] fifo_register [fifo_depth-1:0];
	reg [addr_size-1:0] push_ptr; // ptr that need to write data.(not last data position)
	reg [addr_size-1:0] pop_ptr;  // point to the oldest (first out) data.
	reg [addr_size-1:0] cnt; // count # of data in FIFO
	integer i;
	
	assign is_full  = (push_ptr==pop_ptr && cnt!=0) ? 1 : 0;
	assign is_empty = (push_ptr==pop_ptr && cnt==0) ? 1 : 0;
	
	always@(posedge clk or negedge rst_n)begin
		if(!rst_n) begin
			push_ptr <= 0;
			pop_ptr  <= 0;
			cnt      <= 0;
		end
		else begin
			if (push && pop) begin 
				push_ptr <= push_ptr + 1'b1;
				pop_ptr  <= pop_ptr  + 1'b1;
				cnt      <= cnt;
			end
			else if (push) begin 
				push_ptr <= push_ptr + 1'b1;
				pop_ptr  <= pop_ptr;
				cnt      <= cnt + 1'b1;
			end
			else if (pop) begin 
				push_ptr <= push_ptr;
				pop_ptr  <= pop_ptr  + 1'b1;
				cnt      <= cnt - 1'b1;
			end
			else begin 
				push_ptr <= push_ptr;
				pop_ptr  <= pop_ptr;
				cnt      <= cnt;
			end
		end	
	end
	
	always@(posedge clk or negedge rst_n)begin
		if(!rst_n) for(i=0;i<fifo_depth;i=i+1) fifo_register[i] <= 32'b0;
		else begin
			if (push) fifo_register[push_ptr] <= i_data;
			else fifo_register[push_ptr] <= fifo_register[push_ptr];
		end
	end 
	
	assign o_data = fifo_register[pop_ptr];	
	
endmodule 
