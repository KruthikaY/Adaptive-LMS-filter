module input_read #(
    parameter N = 20,
    parameter WIDTH = 8
)(
    input logic clk,
    input logic rst,
    output logic signed [WIDTH-1:0] x_out
);

    logic [$clog2(N)-1:0] index;
    logic signed [WIDTH-1:0] mem [0:N-1];

    initial begin
        $readmemh("input.hex", mem);
    end

    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            index <= 0;
        else if (index < N)
            index <= index + 1;
    end

    assign x_out = mem[index];

endmodule
