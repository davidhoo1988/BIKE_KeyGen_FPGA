onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib mem_h_opt

do {wave.do}

view wave
view structure
view signals

do {mem_h.udo}

run -all

quit -force
