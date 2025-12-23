package counter_pkg;
int no_of_trans = 1;

`include "transaction.sv"
`include"generator.sv"
`include"driver.sv"
`include"write_monitor.sv"
`include"read_monitor.sv"
`include"model.sv"
`include"scoreboard.sv"
`include"environment.sv"
`include"test.sv"
endpackage
