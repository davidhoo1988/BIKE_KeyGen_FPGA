######################################################################
#
# File name : prng_lcg_tb_simulate.do
# Created on: Mon Feb 25 20:16:31 +0800 2019
#
# Auto generated by Vivado for 'behavioral' simulation
#
######################################################################
vsim -voptargs="+acc" -L xbip_utils_v3_0_9 -L xbip_pipe_v3_0_5 -L xbip_bram18k_v3_0_5 -L mult_gen_v12_0_14 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -L xpm -lib xil_defaultlib xil_defaultlib.prng_lcg_tb xil_defaultlib.glbl

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {prng_lcg_tb_wave.do}

view wave
view structure
view signals

do {prng_lcg_tb.udo}

run 1000ns