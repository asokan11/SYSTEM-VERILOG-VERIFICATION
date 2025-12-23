class counter_gen;

counter_trans data2send;
counter_trans gen2drv;

mailbox #(counter_trans) gen2dr;

function new(mailbox #(counter_trans) gen2dr);
this.gen2dr = gen2dr;
this.data2send = new;
endfunction

virtual task start();
fork
 begin
    for(int i = 0; i < no_of_trans; i++)
	begin
	assert(data2send.randomize());
	gen2drv = new data2send;
	gen2dr.put(gen2drv);
	end
 end
join_none
endtask
endclass