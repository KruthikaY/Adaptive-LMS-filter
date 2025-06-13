`timescale 1ns / 1ps

module top_tb;

    logic clk;
    logic rst;

    top uut (
        .clk(clk),
        .rst(rst)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk;

    // Reset logic
    initial begin
        rst = 1;
        #20;
        rst = 0;
    end

    integer cycle;
    integer f;
    initial begin
        f = $fopen("log.txt", "w");
        cycle = 0;

        @(negedge rst);

        repeat (25) begin
            @(posedge clk);
            $display("Cycle %0d | x = %0d | d = %0d | y = %0d | e = %0d",
                cycle,
                uut.x_in,
                uut.d_in,
                uut.y_out,
                uut.e_out
            );
            $display("Weights: %0d, %0d, %0d, %0d\n",
                uut.weights[0],
                uut.weights[1],
                uut.weights[2],
                uut.weights[3]
            );

            $fdisplay(f, "Cycle %0d | x=%0d | d=%0d | y=%0d | e=%0d | w0=%0d w1=%0d w2=%0d w3=%0d",
                cycle,
                uut.x_in,
                uut.d_in,
                uut.y_out,
                uut.e_out,
                uut.weights[0],
                uut.weights[1],
                uut.weights[2],
                uut.weights[3]
            );

            cycle++;
        end

        $display("Simulation complete.");
        $fclose(f);
        $finish;
    end

endmodule
