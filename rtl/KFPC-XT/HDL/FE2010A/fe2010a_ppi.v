module fe2010a_ppi
(
    input         clk,
    input         rst,
    input         enable,
    input  [19:0] address,
    input  [7:0]  data_bus_in,
    input         io_read_n,
    input         io_write_n,
    input         address_enable_n,
    output [7:0]  control_reg,
    output [7:0]  config_reg,
    output [7:0]  data_bus_out,
    output        data_bus_out_from_chipset
);

    reg [7:0] control_reg_r;
    reg [7:0] config_reg_r;

    wire control_select = enable && ~address_enable_n && (address[15:0] == 16'h0062);
    wire config_select  = enable && ~address_enable_n && (address[15:0] == 16'h0063);
    wire config_locked  = config_reg_r[3];

    always @(posedge clk or posedge rst)
    begin
        if (rst)
        begin
            control_reg_r <= 8'h00;
            config_reg_r  <= 8'h01;
        end
        else
        begin
            if (control_select && ~io_write_n && ~config_locked)
                control_reg_r <= data_bus_in;

            if (config_select && ~io_write_n)
            begin
                if (config_locked)
                    config_reg_r[7:5] <= data_bus_in[7:5];
                else
                    config_reg_r <= data_bus_in;
            end
        end
    end

    assign control_reg = control_reg_r;
    assign config_reg = config_reg_r;

    assign data_bus_out = (control_select && ~io_read_n) ? control_reg_r :
                          (config_select  && ~io_read_n) ? config_reg_r  : 8'h00;

    assign data_bus_out_from_chipset = (control_select && ~io_read_n) ||
                                       (config_select  && ~io_read_n);

endmodule
