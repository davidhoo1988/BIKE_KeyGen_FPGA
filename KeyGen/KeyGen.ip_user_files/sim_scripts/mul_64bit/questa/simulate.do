onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib mul_64bit_opt

do {wave.do}

view wave
view structure
view signals

do {mul_64bit.udo}

run -all

quit -force
