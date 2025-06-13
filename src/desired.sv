module desired #(
    parameter N = 20,
    parameter WIDTH = 8
)(
    input logic clk,
    input logic rst,
    output logic signed [WIDTH-1:0] d_out
);

    logic [$clog2(N)-1:0] index;
    logic signed [WIDTH-1:0] mem [0:N-1];

    initial begin
        $readmemh("desired.hex", mem);
    end

    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            index <= 0;
        else if (index < N)
            index <= index + 1;
    end

    assign d_out = mem[index];

endmodule
