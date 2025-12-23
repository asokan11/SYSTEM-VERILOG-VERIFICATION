class counter_drv;

virtual counter_if.DRV dr_if;

counter_trans data2duv;

mailbox #(counter_trans)gen2dr;

function new(virtual counter_if.DRV dr_if,
             mailbox #(counter_trans)gen2dr);
this.gen2dr = gen2dr;
this.dr_if = dr_if;
endfunction

virtual task drive();
@(dr_if.dr_cb);
dr_if.dr_cb.load <= data2duv.load;
dr_if.dr_cb.up_down <= data2duv.up_down;
dr_if.dr_cb.din <= data2duv.din;
endtask

virtual task start();
fork
  forever begin
    gen2dr.get(data2duv);
	drive();
	end
join_none
endtask
endclass
