
class test;
virtual counter_if.DRV dr_if;
virtual counter_if.WR_MON wrmon_if;
virtual counter_if.RD_MON rdmon_if;

env env_h;

function new(virtual counter_if.DRV dr_if,
            virtual counter_if.WR_MON wrmon_if,
            virtual counter_if.RD_MON rdmon_if);
this.dr_if = dr_if;
this.wrmon_if = wrmon_if;
this.rdmon_if = rdmon_if;
env_h = new(dr_if, wrmon_if, rdmon_if);
endfunction

 virtual task build();
      env_h.build();
   endtask: build
   
   virtual task run();              
      env_h.run();
   endtask: run
   

   
endclass