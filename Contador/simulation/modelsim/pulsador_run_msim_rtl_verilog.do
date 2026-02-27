transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/Contador {C:/intelFPGA_lite/18.1/Contador/pulsador.v}

vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/Contador {C:/intelFPGA_lite/18.1/Contador/test_pulsador.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L maxii_ver -L rtl_work -L work -voptargs="+acc"  test_pulsador

add wave *
view structure
view signals
run -all
