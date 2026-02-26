// 1) 0..F a 7 segmentos (ánodo común: cátodos activos en bajo)
module bcd_a_7seg_anodo_comun (
    input  [3:0] bcd,
    output reg [6:0] catodo  // {a,b,c,d,e,f,g}, 0 = encendido
);
    always @* begin
        case (bcd)
            4'd0:  catodo = 7'b0000001;
            4'd1:  catodo = 7'b1001111;
            4'd2:  catodo = 7'b0010010;
            4'd3:  catodo = 7'b0000110;
            4'd4:  catodo = 7'b1001100;
            4'd5:  catodo = 7'b0100100;
            4'd6:  catodo = 7'b0100000;
            4'd7:  catodo = 7'b0001111;
            4'd8:  catodo = 7'b0000000;
            4'd9:  catodo = 7'b0000100;
            4'd10: catodo = 7'b0001000; // A
            4'd11: catodo = 7'b1100000; // b
            4'd12: catodo = 7'b0110001; // C
            4'd13: catodo = 7'b1000010; // d
            4'd14: catodo = 7'b0110000; // E
            4'd15: catodo = 7'b0111000; // F
            default: catodo = 7'b1111111;
        endcase
    end
endmodule

// 2) Antirrebote (nivel estable)
module antirrebote #(
    parameter CLK_HZ = 50_000_000,
    parameter DEBOUNCE_MS = 10
)(
    input  clk,
    input  nivel,       // 1 = pulsado (ya invertido si era activo en bajo)
    output reg estable
);
    localparam integer LIM = (CLK_HZ/1000)*DEBOUNCE_MS;
    reg [31:0] cnt = 0;
    reg s0=0, s1=0, prev=0;
    always @(posedge clk) begin
        s0 <= nivel; s1 <= s0;
        if (s1 == prev) begin
            if (cnt < LIM) cnt <= cnt + 1; else estable <= s1;
        end else begin
            prev <= s1; cnt <= 0;
        end
    end
endmodule

// 3) TOP: valor desde interruptores y selección de ánodo con botones
module practica2 #(
    parameter CLK_HZ = 50_000_000,
    parameter BOTON_ACTIVO_BAJO = 1
)(
    input        clk,
    input  [3:0] interruptor,   // usa interruptor[3:0] = HEX 0..F
    input  [3:0] boton,         // BTN3..BTN0 para elegir AN3..AN0
    output [6:0] catodo,        // CA..CG (activos en bajo)
    output       punto,         // DP (activo en bajo)
    output [3:0] anodo          // AN3..AN0 (activos en bajo)
);
    wire [3:0] hex = interruptor[3:0];

    wire [3:0] btn_nivel = BOTON_ACTIVO_BAJO ? ~boton : boton;

    wire b0, b1, b2, b3;
    antirrebote #(.CLK_HZ(CLK_HZ)) db0(.clk(clk), .nivel(btn_nivel[0]), .estable(b0));
    antirrebote #(.CLK_HZ(CLK_HZ)) db1(.clk(clk), .nivel(btn_nivel[1]), .estable(b1));
    antirrebote #(.CLK_HZ(CLK_HZ)) db2(.clk(clk), .nivel(btn_nivel[2]), .estable(b2));
    antirrebote #(.CLK_HZ(CLK_HZ)) db3(.clk(clk), .nivel(btn_nivel[3]), .estable(b3));

    reg b0d=0, b1d=0, b2d=0, b3d=0;
    wire ev0 =  b0 & ~b0d;
    wire ev1 =  b1 & ~b1d;
    wire ev2 =  b2 & ~b2d;
    wire ev3 =  b3 & ~b3d;

    reg [1:0] sel = 2'd0; // default AN0
    always @(posedge clk) begin
        b0d <= b0; b1d <= b1; b2d <= b2; b3d <= b3;
        if (ev0) sel <= 2'd0;
        else if (ev1) sel <= 2'd1;
        else if (ev2) sel <= 2'd2;
        else if (ev3) sel <= 2'd3;
    end

    wire [6:0] seg;
    bcd_a_7seg_anodo_comun udec(.bcd(hex), .catodo(seg));

    assign catodo = seg;
    assign punto  = 1'b1;                 // apagado
    assign anodo  = ~(4'b0001 << sel);    // 1110,1101,1011,0111
endmodule
