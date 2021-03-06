######################################################################
#
# File name : blk_mul_tb_simulate.do
# Created on: Thu Apr 11 11:17:59 +0800 2019
#
# Auto generated by Vivado for 'behavioral' simulation
#
######################################################################
vsim -voptargs="+acc" -L xbip_utils_v3_0_9 -L xbip_pipe_v3_0_5 -L xbip_bram18k_v3_0_5 -L mult_gen_v12_0_14 -L xil_defaultlib -L fifo_generator_v13_2_2 -L blk_mem_gen_v8_4_1 -L unisims_ver -L unimacro_ver -L secureip -L xpm -lib xil_defaultlib xil_defaultlib.blk_mul_tb xil_defaultlib.glbl

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {blk_mul_tb_wave.do}

view wave
view structure
view signals

do {blk_mul_tb.udo}

run
