module testcat (
    input  [7:0] sw,        // sw[6:0] = segmentos, sw[7] = punto
    output [6:0] catodo,    // {a,b,c,d,e,f,g}
    output       punto      // dp
);

    // Para ánodo común:
    //  - 0 = LED/segmento encendido
    //  - 1 = LED/segmento apagado
    //
    // Queremos que:
    //  - switch en '1' -> segmento ENCENDIDO
    //  - switch en '0' -> segmento APAGADO
    //
    // Entonces simplemente invertimos los switches.

    assign catodo = ~sw[6:0]; // sw[0] -> a, sw[1] -> b, ..., sw[6] -> g
    assign punto  = ~sw[7];   // sw[7] -> punto decimal

endmodule
