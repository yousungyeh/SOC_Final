module fifo #(
	parameter depth = 8,
	parameter addr_size = 3
)(
	input clk,
	input rst_n,
	input push,
	input pop,
	input [31:0] i_data,
	output reg [31:0] o_data,
	output wire is_full,
	output wire is_empty
);
	reg [31:0] fifo_register [depth-1:0];
	reg [addr_size-1:0] push_ptr;
	reg [addr_size-1:0] pop_ptr;
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
		if(!rst_n) for(i=0;i<depth;i=i+1) fifo_register[i] <= 32'b0;
		else begin
			if (push) fifo_register[push_ptr] <= i_data;
			else fifo_register[push_ptr] <= fifo_register[push_ptr];
		end
	end 
	
	always@(posedge clk or negedge rst_n)begin
		if(!rst_n) o_data <= 32'b0;
		else if(pop) o_data <= fifo_register[pop_ptr];
		else o_data <= o_data;
	end
	
	/*
	reg [31:0] fifo_register [depth-1:0];
	reg [1:0] wr_ptr;
	reg [1:0] rd_ptr;
	reg [2:0] cnt;
	
	
	integer i;
	// write pointer 
	always@(posedge clk or negedge rst_n)begin
		if(!rst_n) wr_ptr <= 0;
		else if (push && !is_full) wr_ptr <= wr_ptr +1'b1;
		else wr_ptr <= wr_ptr;	
	
	end
	// read pointer
	always@(posedge clk or negedge rst_n)begin
		if(!rst_n) rd_ptr <= 0;
		else if (pop && !fifo_empty) rd_ptr <= rd_ptr +1'b1;
		else rd_ptr <= rd_ptr;	
	end
	// data write in fifo
	always@(posedge clk or negedge rst_n)begin
		if(!rst_n) begin
			for(i=0;i<depth;i=i+1) fifo_register[i] <= 32'b0;
		end
		else if(push) fifo_register[wr_ptr] <= i_data;
		else fifo_register[wr_ptr] <= fifo_register[wr_ptr];
	end
	// data read from fifo
	always@(posedge clk or negedge rst_n)begin
		if(!rst_n) o_data <= 32'b0;
		else if(pop) o_data <= fifo_register[rd_ptr];
		else o_data <= o_data;
	end
	// determining whether it is empty or full
	always@(posedge clk or negedge rst_n)begin
		if(!rst_n) cnt <= 3'b0;
		else if(push && !pop && !is_full) cnt <= cnt +1'b1;
		else if(!push && pop && !is_empty) cnt <= cnt -1'b1;
		else cnt <= cnt;
	end
	
	assign is_full  = (cnt==depth) ? 1 : 0;
	assign is_empty = (cnt==0) ? 1 : 0;
	*/
endmodule 
