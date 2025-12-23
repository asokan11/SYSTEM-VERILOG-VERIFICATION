class counter_wrmon;

virtual counter_if.WR_MON wrmon_if;
counter_trans wr_data;
counter_trans data;
  mailbox #(counter_trans)wrmon2rm;

function new(virtual counter_if.WR_MON wrmon_if,
             mailbox#(counter_trans)wrmon2rm);
this.wrmon_if = wrmon_if;
this.wrmon2rm = wrmon2rm;
this.data = new;
endfunction

virtual task monitor();
@(wrmon_if.wr_cb);
data.load = wrmon_if.wr_cb.load;
data.up_down = wrmon_if.wr_cb.up_down;
data.din = wrmon_if.wr_cb.din;
endtask

virtual task start();
fork
begin
forever begin
monitor();
wr_data = new data;
wrmon2rm.put(wr_data);
end
end
join_none
endtask
endclass
