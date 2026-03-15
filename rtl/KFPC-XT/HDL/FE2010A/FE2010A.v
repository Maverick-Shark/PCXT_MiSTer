module FE2010A
(
    input         clock,
    input         reset,
    input  [19:0] address,
    input  [7:0]  data_bus_in,
    input         io_read_n,
    input         io_write_n,
    input         address_enable_n,
    input         enable,
    output [7:0]  data_bus_out,
    output        data_bus_out_from_chipset,
    output [1:0]  clk_select,
    output        fast_wait
);

    wire [7:0] control_reg;
    wire [7:0] config_reg;

    fe2010a_ppi u_fe2010a_ppi
    (
        .clk                        (clock),
        .rst                        (reset),
        .enable                     (enable),
        .address                    (address),
        .data_bus_in                (data_bus_in),
        .io_read_n                  (io_read_n),
        .io_write_n                 (io_write_n),
        .address_enable_n           (address_enable_n),
        .control_reg                (control_reg),
        .config_reg                 (config_reg),
        .data_bus_out               (data_bus_out),
        .data_bus_out_from_chipset  (data_bus_out_from_chipset)
    );

    fe2010a_clkgen u_fe2010a_clkgen
    (
        .config_reg                 (config_reg),
        .clk_select                 (clk_select)
    );

    fe2010a_waitgen u_fe2010a_waitgen
    (
        .config_reg                 (config_reg),
        .fast_wait                  (fast_wait)
    );

endmodule
