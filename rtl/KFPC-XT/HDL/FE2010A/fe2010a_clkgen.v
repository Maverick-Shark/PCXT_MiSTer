module fe2010a_clkgen
(
    input      [7:0] config_reg,
    output reg [1:0] clk_select
);

    always @*
    begin
        case (config_reg[7:5])
            3'b010,
            3'b011: clk_select = 2'b01;

            3'b100,
            3'b110: clk_select = 2'b10;

            default: clk_select = 2'b00;
        endcase
    end

endmodule
