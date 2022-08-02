////////////TEST BENCH FOR VENDING MACHINE////////////

module tb();
  reg clk,rst;
  reg [1:0] coin;
  wire coke;

  parameter no_coin=2'b00, five=2'b01, ten=2'b11;

  vending_machine v1(clk,rst,coin,coke);
  
  initial
    begin
      $dumpfile("output.vcd");
      $dumpvars(0, tb);
      clk = 1'b0; rst = 1'b1;
      #15 rst = 1'b0;
    end
  
  always #5 clk = ~clk;
  
  always @(posedge clk)
    begin
    case (coin)
      no_coin: $display("*****PLEASE INSERT A COIN---WE CAN'T PROCESS YOUR ORDER*****");
      five: $display("1 five rupee coin inserted");
      ten: $display("1 ten rupee coin inserted");
    endcase
      
      if(coke) 
        $display("*****COKE SERVED*****PLEASE VISIT AGAIN*****\n");
    end
  
  initial
    begin
      #12 coin = five;
      #10 coin = five;
      #10 coin = five;
      
      #10 coin = ten;
      #10 coin = five;
      
      
      #10 coin = ten;
      #10 coin = ten;
      
      
      #10 coin = five;
      #10 coin = ten;
      
      
      #10 coin = five;
      #10 coin = no_coin;
      
      #20 $finish;
    end
  
endmodule

      
