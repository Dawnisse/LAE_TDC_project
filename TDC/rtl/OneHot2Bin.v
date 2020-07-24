//
// Convert a one-hot signal to a binary index corresponding to the active bit.
// (Binary encoder)
// If DIRECTION is "LSB0", index 0 corresponds to the least significant bit
// If "MSB0", index 0 corresponds to the most significant bit
//

`timescale 1ns/100ps
 
module OneHot2Bin
 
   (
   
    (*keep = "true"*)input  wire [174:0]   one_hot,
    output reg  [7:0]     index
	
	);
 
    integer oh_index;
  
    always @(*) begin : convert
	
        index = 0;
		
        for (oh_index = 0; oh_index < 175; oh_index = oh_index + 1) begin
            
			if (one_hot[oh_index]) begin
			
                    index = index | oh_index[7:0];    // Use 'or' to avoid synthesizing priority encoder
                
            end // if
        end // for
    end // always
endmodule