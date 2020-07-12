`timescale 1ns / 1ps

module clkdiv(
    input clk,
    output clkout
    );

	reg [15:0] counter;
	assign clkout = counter[15];

	always @(posedge clk) begin
		counter <= counter+1;
	end
endmodule


module seven_seg_mux(
	input clk,
	input [6:0] count_value,
	output reg [6:0] segout
	);
	
	assign segout = count_value;
endmodule



//define our module and it's inputs/outputs
module top(
	input CLK,
	input BTN1,
	output [6:0] seg,
	output ca
    );
	
    assign ca = 0;
    
	//define wires and registers here
	wire displayClock;
	wire btn1_debounced_wire;
	reg[6:0] intermed;
	 	

	//always @ blocks can go here
	always @(negedge BTN1) begin
		intermed = intermed + 1;
	end


	clkdiv displayClockGen(
		.clk(CLK),
		.clkout(displayClock)
	);

	seven_seg_mux display(
		.clk(displayClock),
		.count_value(intermed),
		.segout(seg)
	);

endmodule
