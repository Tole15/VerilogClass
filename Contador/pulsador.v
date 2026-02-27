module pulsador (
    input clk,
    output led
);

reg [25:0] conteo = 26'd0; 

always @(posedge clk)
begin
    conteo <= conteo + 1'b1;
end

//assign led = ~conteo[25];
assign led = 1;
endmodule
