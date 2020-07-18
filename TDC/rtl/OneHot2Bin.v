//
// Convert a one-hot signal to a binary index corresponding to the active bit.
// (Binary encoder)
// If DIRECTION is "LSB0", index 0 corresponds to the least significant bit
// If "MSB0", index 0 corresponds to the most significant bit
//

`timescale 1ns/100ps
 
module OneHot2Bin #(
    
   parameter NUM_SIGNALS = 195,
   parameter DIRECTION = "LSB0",
   parameter INDEX_WIDTH = $clog2(NUM_SIGNALS)
   
   )
 
   (
   
    input      [NUM_SIGNALS - 1:0]   one_hot,
    output reg [INDEX_WIDTH - 1:0]   index
	
	);
 
    integer oh_index;
  
    always @(*) begin : convert
	
        index = 0;
		
        for (oh_index = 0; oh_index < NUM_SIGNALS; oh_index = oh_index + 1) begin
            
			if (one_hot[oh_index]) begin
			
                if (DIRECTION == "LSB0")
                    index = index | oh_index[INDEX_WIDTH - 1:0];    // Use 'or' to avoid synthesizing priority encoder
                else
                    index = index | ~oh_index[INDEX_WIDTH - 1:0];
            end // if
        end // for
    end // always
endmodule