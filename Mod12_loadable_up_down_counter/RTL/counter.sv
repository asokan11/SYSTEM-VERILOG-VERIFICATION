module mod12_counter (
    input logic  [3:0] din,
    input logic        load,
    input logic        up_down,
    input logic        clk,
    input logic        rst,
    output logic [3:0] dout
);

always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
        dout <= 4'd0;
    end
    else if (load) begin
        if (din < 4'd12)
            dout <= din;
        else
            dout <= 4'd0;
    end
    else if (up_down) begin          
        if (dout == 4'd11)
            dout <= 4'd0;
        else
            dout <= dout + 1'b1;
    end
    else begin                       
        if (dout == 4'd0)
            dout <= 4'd11;
        else
            dout <= dout - 1'b1;
    end
end

endmodule
