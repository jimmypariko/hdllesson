/*
 
  CPU_tb.v
  
  Tests CPU.v
  
 */

`include "src/defines.v"

module CPU_tb;

reg clk_cpu;
reg reset;
reg [31:0] test_rom[0:1023];
wire [31:0] pc;

// CPU
CPU CPU0(
  .clk_cpu(clk_cpu),
  .reset(reset),
  .inst(test_rom[(pc - `START_ADRS) / 4]),
  .pc(pc)
);

// clock
initial begin
    clk_cpu = 0;
    forever #`HCYCL clk_cpu = !clk_cpu;
end

// test
initial begin
  
  // load test instructions
  $readmemh("src/inst_tests.txt", test_rom);
  
  // init regs
  reset = 0;
  
  // reset
  test_reset_button();
  
end

// test reset
task test_reset_button;
begin
  reset = 1;
  repeat(5) @(posedge clk_cpu);
  reset = 0;
end
endtask

endmodule