`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:26:50 02/13/2016 
// Design Name: 
// Module Name:    filter 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module filter(
    input clk,
    input [23:0] input_data,
    input reset,
    output reg[23:0] output_data 
	
	);
	
	
	reg [23:0] x_cyc[11:0];//this is the cycling of the data words through the filter
	reg [23:0] y_cyc[11:0];
	
	reg signed[23:0] x_coef[11:0];//coefficients for the A and B terms
	reg signed[23:0] y_coef[11:0];
	
	parameter num_coef = 11; //number of 
	
	//------------------------------------------------------------------------------------------
	wire [23:0]coefa;
	wire [23:0]cyca;
	wire [23:0]coefb;
	wire [23:0]cycb;
	
	reg  [23:0] precoef_a;
	reg  [23:0] precyc_a;
	reg  [23:0] precoef_b;
	reg  [23:0] precyc_b;
	
	reg signed [31:0] pre_accumulateda;
	reg signed [31:0] pre_accumulatedb;
	wire signed[31:0]accumulateda ;
	wire signed[31:0]accumulatedb ;
	
	
	multiply multa(coefa, cyca, accumulateda);
   multiply multb(coefb, cycb, accumulatedb);

	assign coefa = precoef_a;
	assign cyca = precyc_a;
	assign coefb = precoef_b;
	assign cycb = precyc_b;
	
	reg signed [31:0] accumulated_totals[10:0];
	

	//------------------------------------------------------------------------------------------

   reg signed [31:0] preout;

	//reg counter;
	reg counter = 2'd0;
	
	reg mult_clk;
	
	
	always
		begin
		 #(1/11) mult_clk = ~clk;
		end
	
	always@(posedge mult_clk)
	begin
	
	if (counter == 2'd10)
		begin
		precoef_a <=  y_coef[counter+1];
		precyc_a <= y_cyc[counter];
		
		precoef_b <= x_coef[counter];
		precyc_b  <= x_cyc[counter];
		
		//pre_accumulateda[counter]<= accumulateda;
		//pre_accumulatedb[counter]<= accumulatedb;
		counter = 2'd0;
		end
	else
		begin
		precoef_a <=  y_coef[counter+1];
		precyc_a <= y_cyc[counter];
		
		precoef_b <= x_coef[counter];
		precyc_b  <= x_cyc[counter];
		
		//pre_accumulateda[counter]<= accumulateda;
		//pre_accumulatedb[counter]<= accumulatedb;
		counter = counter + 2'd1;
		end
		
		pre_accumulateda[counter]<= accumulateda;
		pre_accumulatedb[counter]<= accumulatedb;
   end	
		  
	always@(posedge clk or posedge reset)
	begin
		if(reset)//set the coefficient buffers to 
			begin
				y_cyc[11] <= 'd0;//extra term
				y_cyc[10] <= 'd0;
				y_cyc[9]  <= 'd0;
				y_cyc[8]  <= 'd0;
				y_cyc[7]  <= 'd0;
				y_cyc[6]  <= 'd0;
				y_cyc[5]  <= 'd0;
				y_cyc[4]  <= 'd0;
				y_cyc[3]  <= 'd0;
				y_cyc[2]  <= 'd0;
				y_cyc[1]  <= 'd0;
				y_cyc[0]  <= 'd0;
				
				x_cyc[11] <= 'd0;//extra term 
				x_cyc[10] <= 'd0;
				x_cyc[9]  <= 'd0;
				x_cyc[8]  <= 'd0;
				x_cyc[7]  <= 'd0;
				x_cyc[6]  <= 'd0;
				x_cyc[5]  <= 'd0;
				x_cyc[4]  <= 'd0;
				x_cyc[3]  <= 'd0;
				x_cyc[2]  <= 'd0;
				x_cyc[1]  <= 'd0;
			end
		else
			begin
			   y_cyc[11] <= y_cyc[10];//extra
				y_cyc[10] <= y_cyc[9];
				y_cyc[9]  <= y_cyc[8];
				y_cyc[8]  <= y_cyc[7];
				y_cyc[7]  <= y_cyc[6];
				y_cyc[6]  <= y_cyc[5];
				y_cyc[5]  <= y_cyc[4];
				y_cyc[4]  <= y_cyc[3];
				y_cyc[3]  <= y_cyc[2];
				y_cyc[2]  <= y_cyc[1];
				y_cyc[1]  <= y_cyc[0];
				y_cyc[0]  <= output_data;
				
				x_cyc[11] <= x_cyc[10];//extra
				x_cyc[10] <= x_cyc[9];
				x_cyc[9]  <= x_cyc[8];
				x_cyc[8]  <= x_cyc[7];
				x_cyc[7]  <= x_cyc[6];
				x_cyc[6]  <= x_cyc[5];
				x_cyc[5]  <= x_cyc[4];
				x_cyc[4]  <= x_cyc[3];
				x_cyc[3]  <= x_cyc[2];
				x_cyc[2]  <= x_cyc[1];
				x_cyc[1]  <= x_cyc[0];
				x_cyc[0]  <= input_data;
				
				/*output_data <= (1/y_coef[0])*((pre_accumulatedb[0]+ pre_accumulatedb[1]+ pre_accumulatedb[2]+pre_accumulatedb[3]+pre_accumulatedb[4]+
									pre_accumulatedb[5]+pre_accumulatedb[6]+pre_accumulatedb[7]+pre_accumulatedb[8]+ pre_accumulatedb[9]+ pre_accumulatedb[10])-
									(pre_accumulateda[0]+ pre_accumulateda[1]+ pre_accumulateda[2]+pre_accumulateda[3]+pre_accumulateda[4]+
									pre_accumulateda[5]+pre_accumulateda[6]+pre_accumulateda[7]+pre_accumulateda[8]+ pre_accumulateda[9]+ pre_accumulateda[10]));*/
			end
	
	end
	
	


	
endmodule
