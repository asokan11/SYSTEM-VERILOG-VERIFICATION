class counter_rdmon;

virtual counter_if.RD_MON rdmon_if;
count_trans rd_data;
count_trans data2sb;
mailbox #(count_trans)dr2sb;

function new(virtual counter_if.RD_MON rdmon_if,
             mailbox #(count_trans)mon2sb);
this.rdmon_if = rdmon_if;
this.mon2sb = mon2sb;
this.rd_data = new;
endfunction

virtual task monitor();
@(rdmon_if.rd_cb);
rd_data.dout = rdmon_if.rd_cb.dout;
rd_data.display("from read monitor");
endtask

virtual task start();
fork
begin
forever begin
monitor();
data2sb = new rd_data;
mon2sb.put(data2sb);
end
end
join_none
endtask
endclass

