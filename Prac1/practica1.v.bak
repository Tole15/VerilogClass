module practica1 #(
    parameter ACTIVO_BAJO = 1'b0
)(
    input  wire [7:0] interruptor,
    output wire [7:0] led
);
    assign led = ACTIVO_BAJO ? ~interruptor : interruptor;
endmodule
