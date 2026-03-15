module fe2010a_waitgen
(
    input      [7:0] config_reg,
    output           fast_wait
);

    assign fast_wait = (config_reg[7:5] == 3'b011) ||
                       (config_reg[7:5] == 3'b110);

endmodule
