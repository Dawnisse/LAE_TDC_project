`timescale 1ns/100ps
module DelayLine(
   
   input wire HIT,CLK
   output wire Z[3:0]
   wire EN,X1,X2,X3,X4
   );
   
   always @(posedge HIT) begin //sensitivity list (aggiorna quando cambia un input)
      EN=1'b1;
	  always @(posedge CLK) begin
	     EN=1'b0;
            if (EN==1'b1)begin
		       X1=1'b1;
			   X2=X1;
			   X3=X2;
			   X4=X1;
            end
            else begin
			Z=[X1,X2,X3,X4];
            end
      end
   end
   
   

endmodule