`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/02/2025 10:20:37 PM
// Design Name: 
// Module Name: temperature_controller
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module temperature_controller(
input clk,reset,input [7:0]temperature,output reg heater_on,AC_on,cooler_on
    );
    
    //threshold value
    parameter [7:0]temp_threshold_low=8'd20;
     parameter [7:0]temp_threshold_medium=8'd30;
      parameter [7:0]temp_threshold_high=8'd45;
      
      always@(posedge clk or posedge reset)begin
      if(reset) begin
      heater_on<=1'b0;
      AC_on<=1'b0;
      cooler_on<=1'b0;
       end
      else if(temperature<temp_threshold_low)
       begin
      heater_on<=1'b1;
      AC_on<=1'b0;
      cooler_on<=1'b0; 
      end
      else if(temperature>=temp_threshold_low && temperature<temp_threshold_medium )
       begin
      heater_on<=1'b0;
      AC_on<=1'b0;
      cooler_on<=1'b0; 
      end
      else if(temperature>=temp_threshold_medium && temperature<temp_threshold_high )
       begin
      heater_on<=1'b0;
      AC_on<=1'b0;
      cooler_on<=1'b1; 
      end
      else if(temperature>=temp_threshold_high )
       begin
      heater_on<=1'b0;
      AC_on<=1'b1;
      cooler_on<=1'b0; 
      end
      
      end
endmodule
//testbench
module testbench( );
    reg clk;
    reg reset;
    reg [7:0] temperature;
    wire heater_on;
    wire AC_on;
    wire cooler_on;

    
    temperature_controller uut (
        .clk(clk), 
        .reset(reset), 
        .temperature(temperature), 
        .heater_on(heater_on), 
        .AC_on(AC_on), 
        .cooler_on(cooler_on)
    );

    
    always begin
        #5 clk = ~clk; 
    end

   
    initial begin
       
        clk = 0;
        reset = 0;
        temperature = 8'd0;

        
        $display("Applying reset...");
        reset = 1; #10;
        reset = 0; #10;

        
        $display("Test case 1: Temperature = 15°C (Heater on)");
        temperature = 8'd15;
        #20;
        $display("heater_on = %b, AC_on = %b, cooler_on = %b", heater_on, AC_on, cooler_on);

        
        $display("Test case 2: Temperature = 25°C (No device on)");
        temperature = 8'd25;
        #20;
        $display("heater_on = %b, AC_on = %b, cooler_on = %b", heater_on, AC_on, cooler_on);

     
        $display("Test case 3: Temperature = 35°C (Cooler on)");
        temperature = 8'd35;
        #20;
        $display("heater_on = %b, AC_on = %b, cooler_on = %b", heater_on, AC_on, cooler_on);

        
        $display("Test case 4: Temperature = 50°C (AC on)");
        temperature = 8'd50;
        #20;
        $display("heater_on = %b, AC_on = %b, cooler_on = %b", heater_on, AC_on, cooler_on);

       
        $display("Test case 5: Temperature = 20°C (No device on)");
        temperature = 8'd20;
        #20;
        $display("heater_on = %b, AC_on = %b, cooler_on = %b", heater_on, AC_on, cooler_on);

       
        $display("Test case 6: Temperature = 30°C (No device on)");
        temperature = 8'd30;
        #20;
        $display("heater_on = %b, AC_on = %b, cooler_on = %b", heater_on, AC_on, cooler_on);

       
        $display("Test case 7: Temperature = 45°C (No device on)");
        temperature = 8'd45;
        #20;
        $display("heater_on = %b, AC_on = %b, cooler_on = %b", heater_on, AC_on, cooler_on);

        
        $finish;
    end
endmodule
