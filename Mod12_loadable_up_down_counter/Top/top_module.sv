module top;

  import counter_pkg::*;

  parameter cycle = 10;

  logic clk;

  // Interface instance
  counter_if DUV_IF (clk);

  // Test handle
  test test_h;

  // DUT instantiation (connected via interface)
  counter DUT (
    .clk     (clk),
    .rst     (DUV_IF.rst),
    .load    (DUV_IF.load),
    .up_down (DUV_IF.up_down),
    .din     (DUV_IF.din),
    .dout    (DUV_IF.dout)
  );
   // Clock generation
  initial begin
    clk = 1'b0;
    forever #(cycle/2) clk = ~clk;
  end

  // Test execution
  initial begin
    test_h = new(DUV_IF.DRV,
                 DUV_IF.WR_MON,
                 DUV_IF.RD_MON);

    no_of_trans = 10;

    test_h.build();
    test_h.run();
	$finish;
  end

endmodule