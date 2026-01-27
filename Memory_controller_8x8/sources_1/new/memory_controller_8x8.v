module memory_controller_8x8 (
    input  wire       clk,
    input  wire       reset,
    input  wire       we,        // write enable
    input  wire       re,        // read enable
    input  wire [2:0] addr,      // 8-depth -> 3-bit address
    input  wire [7:0] din,       // 8-bit data input
    output reg  [7:0] dout       // 8-bit data output
);

    // 8 locations, each 8 bits wide
    reg [7:0] mem [0:7];

    always @(posedge clk) begin
        if (reset) begin
            dout <= 8'd0;
        end else begin
            // Write operation
            if (we)
                mem[addr] <= din;

            // Read operation (synchronous)
            if (re)
                dout <= mem[addr];
        end
    end

endmodule
