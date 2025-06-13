module lms #(
    parameter N = 4,
    parameter WIDTH = 8,
    parameter MU = 8'd13  //  0.1 in Q1.7
)(
    input  logic clk,
    input  logic rst,

    input  logic signed [WIDTH-1:0] x_in,
    input  logic signed [WIDTH-1:0] d_in,

    output logic signed [WIDTH-1:0] y_out,
    output logic signed [WIDTH-1:0] e_out,
    output logic signed [WIDTH-1:0] weights [N-1:0]
);

    logic signed [WIDTH-1:0] x_reg [N-1:0];
    logic signed [2*WIDTH-1:0] mult [N-1:0];
    logic signed [2*WIDTH-1:0] acc;
    logic signed [2*WIDTH-1:0] e_ext;
    logic signed [2*WIDTH-1:0] w_update;

    integer i, j;

    // Shift register
    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            for (i = 0; i < N; i++) x_reg[i] <= 0;
        else begin
            for (i = N-1; i > 0; i--) x_reg[i] <= x_reg[i-1];
            x_reg[0] <= x_in;
        end
    end

    // Output: y = sum(w_i * x[n-i])
    always_comb begin
        acc = 0;
        for (j = 0; j < N; j++) begin
            mult[j] = x_reg[j] * weights[j];
            acc += mult[j];
        end
        y_out = acc[WIDTH + 6 -: WIDTH];  // Q1.7 truncation
    end

   assign e_ext = {{WIDTH{d_in[WIDTH-1]}} , d_in} - {{WIDTH{y_out[WIDTH-1]}}, y_out};  // sign-extended subtraction
   assign e_out = e_ext[WIDTH-1:0];  // truncate safely for output


    // Weight update
    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            for (i = 0; i < N; i++) weights[i] <= 0;
        else begin
            for (i = 0; i < N; i++) begin
                w_update = (MU * e_ext * x_reg[i]) >>> 7; // Scaling
                weights[i] <= weights[i] + w_update[WIDTH-1:0];
            end
        end
    end

endmodule
