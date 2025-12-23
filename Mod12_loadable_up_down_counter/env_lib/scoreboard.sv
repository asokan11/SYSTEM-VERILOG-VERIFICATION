class counter_sb;

    event DONE;

    // Transactions
    counter_trans exp_data;
    counter_trans act_data;

    // Counters
    int total_checked = 0;
    int total_passed  = 0;

    // Mailboxes
    mailbox #(counter_trans) ref2sb;
    mailbox #(counter_trans) rdmon2sb;

    // Constructor
    function new(mailbox #(counter_trans) ref2sb,
                 mailbox #(counter_trans) rdmon2sb);
        this.ref2sb    = ref2sb;
        this.rdmon2sb  = rdmon2sb;
    endfunction

    // Compare task
    task check(counter_trans exp, counter_trans act);
        total_checked++;

        if (exp.dout == act.dout) begin
            total_passed++;
            $display("[SB] PASS : expected=%0d actual=%0d",
                      exp.dout, act.dout);
        end
        else begin
            $display("[SB] FAIL : expected=%0d actual=%0d",
                      exp.dout, act.dout);
        end

        if (total_checked >= no_of_transactions) begin
            -> DONE;
        end
    endtask

    // Start task
    task start();
        forever begin
            ref2sb.get(exp_data);      // expected from RM
            rdmon2sb.get(act_data);    // actual from read monitor
            check(exp_data, act_data);
        end
    endtask

    // Report
    function void report();
        $display("----------- SCOREBOARD REPORT ------------");
        $display("Total checked : %0d", total_checked);
        $display("Total passed  : %0d", total_passed);
        $display("Total failed  : %0d",
                  total_checked - total_passed);
        $display("------------------------------------------");
    endfunction

endclass
