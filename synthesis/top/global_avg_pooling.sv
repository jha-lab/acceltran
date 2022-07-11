module global_avg_pooling
(
    clk,            //i
    im,             //i
    en,             //i
    size,           //i
    input_ready,    //i
    om,             //o
    done            //o
);

parameter IL = 4, FL = 16;

input clk, en, input_ready;
input signed [IL+FL-1:0] im;
input [IL+FL-1:0] size;     //kernel size kxk per channel

output logic signed [IL+FL-1:0] om;
output logic done;

logic signed [IL+FL-1:0] sum;
logic [IL+FL-1:0] counter;

always_ff @(posedge clk) begin
    if (en == 1) begin
        if (input_ready == 1) begin
            om <= {(IL+FL){1'b0}};
        end
        else begin
            if (done == 1) begin
                om <= sum / size;
            end
            else begin
                om <= om;
            end
        end
    end
end

always_comb begin
    if (en == 1) begin
        if (input_ready == 1) begin
            sum = 0;
            counter = 0;
        end
        else begin
            sum = sum + im;
            counter = counter + 1;
        end
        done = (counter == size) ? 1 : 0;
    end
end

endmodule
