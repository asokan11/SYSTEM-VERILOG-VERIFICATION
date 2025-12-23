interface counter_if(input bit clk);
logic load;
logic up_down;
logic [3:0]din;
logic [3:0]dout;
logic rst;

//driver clocking block

clocking dr_cb @(posedge clk);
default input #1 output #1;
output load;
output up_down;
output din;
output rst;
endclocking

// write monitor clocking block

clocking wr_cb @(posedge clk);
default input #1 output #1;
input load;
input up_down;
input din;
endclocking

//read monitor clocking block

clocking rd_cb @(posedge clk);
default input #1 output #1;
input dout;
endclocking

//modport for driver
modport DRV (clocking dr_cb);

//modport for wr monitor
modport WR_MON (clocking wr_cb);

//modport for read monitor
modport RD_MON(clocking rd_cb);


endinterface
