`timescale 1ns/1ps
module seq_det_1001(y,x,clk,rst);
output reg y;
input x,clk,rst;
reg [2:0] state,next_state;
parameter a=3'b000,
	  b=3'b001,
          c=3'b010,
	  d=3'b011,
	  e=3'b100;
always @(posedge clk or posedge rst)
begin
  if(rst)
	state <= a;
  else 
	state <= next_state;
end
always @(state or x)
begin
    case(state)
	a:if(x == 1)
		next_state <= b;
	  else
		next_state <= a;
	b:if(x == 1)
		next_state <= b;
	  else
		next_state <= c;
	c:if(x == 1)
		next_state <= b;
	  else 
		next_state <= d;
	d:if(x == 1)
		next_state <= e;
	  else 
		next_state <= a;
	e:if(x == 1)
		next_state <= b;
	  else
		next_state <= c;

endcase
end
always @(state)
begin
  case(state)
	a:y=0;
	b:y=0;
	c:y=0;
	d:y=0;
	e:y=1;
   default:y=0;
  endcase  
end
endmodule
