////////////DESIGN BENCH FOR VEDING MACHINE///////////////
module vending_machine(
  					input clk,
  					input rst,
                    input [1:0] coin,
  					output reg coke );
  
  // Input coins//
  parameter no_coin=2'b00, five=2'b01, ten=2'b11; 
  
  /* STATES :   s0 - State with 1-five or 1-ten or no coin input
  			    s1 - State with 1-five+1-ten or 1-ten+1-five or 2-tens but no extra money returned
  	            s2 - State with 2-fives
                s3 - State with 3-fives*/ 
  
  //Defining parameters for respective coin inputs//
  parameter s0=0, s1=1, s2=2, s3=3;
  
  reg [1:0] cur_state, next_state;
  
  always @(posedge clk)
    if(rst) cur_state <= s0;
  	else cur_state <= next_state;
    
  always @(cur_state, coin)
    case (cur_state)
      
      s0: begin
        coke <= 1'b0;
        case (coin)
          no_coin: begin
			next_state <= s0; 
          end
          ten   : next_state <= s1;
          five  : next_state <= s2;
        endcase
      end
      
      s1: begin
        case (coin)
          no_coin: next_state <= s1;
          
          ten   : begin
           coke <= 1'b1;
            next_state <= s0;
          end
          
          five : begin
            coke <= 1'b1;
            next_state <= s0;
          end
        endcase
      end
      
      s2: begin
        case (coin)
          no_coin: next_state <= s2;
          
          ten   : begin
            coke <= 1'b1;
            next_state <= s0;
          end
          
          five : begin
            next_state <= s3;
          end
        endcase
      end
      
      s3: begin
        case (coin)
          no_coin: next_state <= s3;
          
          five : begin
            coke <= 1'b1;
            next_state <= s0;
          end
        endcase
      end
    endcase
  
endmodule
          
          
          
            
          
