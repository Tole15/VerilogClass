module test_pulsador;
    reg clk_sexo;
    reg reset_sexo;
    wire led_anal;

    pulsador DUT (
        .clk(clk_sexo),
        .reset(reset_sexo),
        .led(led_anal)
    );  
	 
    always #5 clk_sexo = ~clk_sexo;

    initial 
	 begin
        clk_sexo = 0;
        reset_sexo = 0;  
        #200;
        reset_sexo = 1;
        #10;
        reset_sexo = 0;
        #180;
        
        $stop;
    end 
endmodule
