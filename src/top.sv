module top #(parameter N = 20, WIDTH = 8) (
    input logic clk,
    input logic rst
);

    // Wires for interconnecting modules
    logic signed [WIDTH-1:0] x_in;
    logic signed [WIDTH-1:0] d_in;
    logic signed [WIDTH-1:0] y_out;
    logic signed [WIDTH-1:0] e_out;
    logic signed [WIDTH-1:0] weights [0:3]; 

    // Input signal memory reader
    input_read #(.N(N), .WIDTH(WIDTH)) input_mem (
        .clk(clk),
        .rst(rst),
        .x_out(x_in)
    );

    // Desired signal memory reader
    desired #(.N(N), .WIDTH(WIDTH)) desired_mem (
        .clk(clk),
        .rst(rst),
        .d_out(d_in)
    );

    // LMS filter core 
    lms #(.N(4), .WIDTH(WIDTH)) lms (
        .clk(clk),
        .rst(rst),
        .x_in(x_in),
        .d_in(d_in),
        .y_out(y_out),
        .e_out(e_out),
        .weights(weights)
    );

endmodule
