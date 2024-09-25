transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/meron/Quartas\ Projects/Counter\ 4 {C:/Users/meron/Quartas Projects/Counter 4/Counter4.v}

vlog -vlog01compat -work work +incdir+C:/Users/meron/Quartas\ Projects/Counter\ 4 {C:/Users/meron/Quartas Projects/Counter 4/Counter4_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  Counter4_tb

add wave *
view structure
view signals
run -all
