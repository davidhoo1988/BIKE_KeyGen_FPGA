vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work xil_defaultlib -64 -incr \
"../../../../KeyGen.ip/mem_g/sim/mem_g.v" \


vlog -work xil_defaultlib \
"glbl.v"
