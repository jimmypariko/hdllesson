/*
 
  CPU32.v
  
  The top level module.
  
 */

`include "src/defines.v"

module CPU32 (
  input   clk,
  input   btn0_n,
  input   [9:0] sw,
  output  [7:0] led0_n,
  output  [7:0] led1_n,
  output  [7:0] led2_n,
  output  [7:0] led3_n
);

  // reset signal
  wire reset;
  chattering_canceler chattering_canceler0(
    .clk(clk), 
    .dat_in_n(btn0_n), 
    .dat_out(reset)
  );

  // cpu clock prescaling
  wire clk_cpu, clk_stp;
  clock_prescaler clock_prescaler0(
    .clk(clk), 
    .reset(reset), 
    .clk_cpu(clk_cpu),
    .clk_stp(clk_stp)
  );

  // instruction rom
  wire [`WORD] inst;
  wire [`WORD] pc;
  rom rom0(
    .pc(pc), 
    .inst(inst)
  );
  
  // CPU
  wire [`WORD] reg_dbg_q;
  wire [4:0] reg_dbg_adrs = sw[4:0];
  CPU CPU0(
    .clk_cpu(clk_cpu),
    .reset(reset),
    .inst(inst),
	 .reg_dbg_adrs(reg_dbg_adrs),
    .pc(pc),
	 .reg_dbg_q(reg_dbg_q)
  );
  
  // LED display to show PC and registers
  // (sw9: pc or reg, sw8: hi or lo, sw4-0: reg adrs)
  wire [15:0] led_output = sw[9:9] ? pc[15:0] : 
	sw[8:8] ? reg_dbg_q[31:15] : reg_dbg_q[15:0];
  led_decoder led_decoder3(led_output[3:0], clk_cpu, 1'b1, led3_n);
  led_decoder led_decoder2(led_output[7:4], 1'b0, 1'b1, led2_n);
  led_decoder led_decoder1(led_output[11:8], 1'b0, 1'b1, led1_n);
  led_decoder led_decoder0(led_output[15:12], 1'b0, 1'b1, led0_n);
  
endmodule