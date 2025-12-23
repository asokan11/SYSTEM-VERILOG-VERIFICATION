class counter_trans;

rand bit load;
rand bit up_down;
rand logic [3:0]din;
logic [3:0]dout;

constraint C1 {
                load dist {0 := 60, 1 := 40};
			  }
constraint C2{
                up_down dist {0 := 60, 1 := 40};
             }
constraint C3{
            if (load)
            din inside {[0:11]};
    }
	
function void display(input string s);
$display("------------RANDOMIZED DATA--------------------");
$display("%s",s);
$display("load = %b",load);
$display("up_down = %b",up_down);
$display("din = %b",din);
$display("------------------------------------------------");
endfunction
endclass
