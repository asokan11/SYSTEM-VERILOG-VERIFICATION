class env;

  // Virtual interfaces
  virtual counter_if.DRV    dr_if;
  virtual counter_if.WR_MON wrmon_if;
  virtual counter_if.RD_MON rdmon_if;

  // Mailboxes
  mailbox #(counter_trans) gen2dr  = new();
  mailbox #(counter_trans) mon2rm  = new();
  mailbox #(counter_trans) rm2sb   = new();
  mailbox #(counter_trans) mon2sb  = new();

  // Component handles
  counter_gen      gen_h;
  counter_drv           dri_h;
  counter_wrmon    wrmon_h;
  counter_rdmon    rdmon_h;
  counter_model    mod_h;
  counter_sb       sb_h;

  // Constructor
  function new(virtual counter_if.DRV dr_if,
               virtual counter_if.WR_MON wrmon_if,
               virtual counter_if.RD_MON rdmon_if);
    this.dr_if    = dr_if;
    this.wrmon_if = wrmon_if;
    this.rdmon_if = rdmon_if;
  endfunction

  // Build phase
  virtual task build();
    gen_h   = new(gen2dr);
    dri_h   = new(dr_if, gen2dr);
    wrmon_h = new(wrmon_if, mon2rm);
    rdmon_h = new(rdmon_if, mon2sb);
    mod_h   = new(mon2rm, rm2sb);
    sb_h    = new(rm2sb, mon2sb);
  endtask

  // Reset DUT
  virtual task reset_duv();
    @(dr_if.dr_cb);
    dr_if.dr_cb.rst <= 1'b1;
    repeat (2) @(dr_if.dr_cb);
    dr_if.dr_cb.rst <= 1'b0;
  endtask

  // Start all components
  virtual task start();
    fork
      gen_h.start();
      dri_h.start();
      wrmon_h.start();
      rdmon_h.start();
      mod_h.start();
      sb_h.start();
    join_none
  endtask

  // Stop condition
  virtual task stop();
    wait (sb_h.DONE.triggered);
  endtask

  // Run phase
  virtual task run();
    build();
    reset_duv();
    start();
    stop();
    sb_h.report();
  endtask

endclass
