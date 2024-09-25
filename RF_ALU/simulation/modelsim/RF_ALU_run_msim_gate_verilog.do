transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vlog -vlog01compat -work work +incdir+. {RF_ALU.vo}

vlog -vlog01compat -work work +incdir+C:/Users/meron/QuartasProjects/RF_ALU {C:/Users/meron/QuartasProjects/RF_ALU/RF_ALU_tb.v}

vsim -t 1ps +transport_int_delays +transport_path_delays -L altera_ver -L altera_lnsim_ver -L cyclonev_ver -L lpm_ver -L sgate_ver -L cyclonev_hssi_ver -L altera_mf_ver -L cyclonev_pcie_hip_ver -L gate_work -L work -voptargs="+acc"  RF_ALU_tb

add wave *
view structure
view signals
run -all
