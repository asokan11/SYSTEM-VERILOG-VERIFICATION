class counter_model;

counter_trans inp_trans;
counter_trans exp_trans;
logic [3:0]ref_count = 4'd0;

mailbox #(counter_trans)wrmon2rm;
mailbox #(counter_trans)rm2sb;

function new(mailbox #(counter_trans)wrmon2rm,
             mailbox #(counter_trans)rm2sb);
this.wrmon2rm = wrmon2rm;
this.rm2sb = rm2sb;
endfunction

task model(counter_trans tr);
    if (tr.load) begin
        if (tr.din < 4'd12)
            ref_count = tr.din;
        else
            ref_count = 4'd0;
    end
    else if (tr.up_down) begin          // COUNT UP
        if (ref_count == 4'd11)
            ref_count = 4'd0;
        else
            ref_count = ref_count + 1'b1;
    end
    else begin                       // COUNT DOWN
        if (ref_count == 4'd0)
            ref_count = 4'd11;
        else
            ref_count = ref_count - 1'b1;
    end
	endtask
	
task start();
fork
begin
forever begin
wrmon2rm.get(inp_trans);
model(inp_trans);
exp_trans = new inp_trans;
exp_trans.dout = ref_count;
rm2sb.put(exp_trans);
end
end
join_none
endtask
endclass
	