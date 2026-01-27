`timescale 1ns / 1ps

module tb_memory_controller_8x8;

    reg        clk;
    reg        reset;
    reg        we;
    reg        re;
    reg [2:0]  addr;
    reg [7:0]  din;
    wire [7:0] dout;

    // Instantiate DUT (Device Under Test)
    memory_controller_8x8 dut (
        .clk   (clk),
        .reset (reset),
        .we    (we),
        .re    (re),
        .addr  (addr),
        .din   (din),
        .dout  (dout)
    );

    // Clock generation (10 ns period)
    always #5 clk = ~clk;

    initial begin
        // Initial values
        clk   = 0;
        reset = 1;
        we    = 0;
        re    = 0;
        addr  = 0;
        din   = 0;

        // Apply reset
        #10;
        reset = 0;

        // -------------------------
        // WRITE: write 10 to location 7
        // -------------------------
        addr = 3'd7;
        din  = 8'd10;
        we   = 1;
        #10;            // wait for one clock
        we   = 0;

        // -------------------------
        // READ: read from location 7
        // -------------------------
        re   = 1;
        #10;            // wait for one clock
        re   = 0;

        // -------------------------
        // WRITE multiple locations
        // -------------------------
        we = 1;
        addr = 3'd0; din = 8'd5;  #10;
        addr = 3'd1; din = 8'd15; #10;
        addr = 3'd2; din = 8'd25; #10;
        we = 0;

        // -------------------------
        // READ multiple locations
        // -------------------------
        re = 1;
        addr = 3'd0; #10;
        addr = 3'd1; #10;
        addr = 3'd2; #10;
        re = 0;

        #20;
        $finish;
    end

endmodule


   