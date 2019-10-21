# 
# Synthesis run script generated by Vivado
# 

proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_param simulator.modelsimInstallPath F:/modelsim64_10.5/win64
create_project -in_memory -part xc7a75tfgg484-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir C:/Users/David/Desktop/KeyGen-2/KeyGen.cache/wt [current_project]
set_property parent.project_path C:/Users/David/Desktop/KeyGen-2/KeyGen.xpr [current_project]
set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo c:/Users/David/Desktop/KeyGen-2/KeyGen.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_verilog -library xil_defaultlib {
  C:/Users/David/Desktop/KeyGen-2/src/core_ctrl.v
  C:/Users/David/Desktop/KeyGen-2/src/g_ctrl.v
  C:/Users/David/Desktop/KeyGen-2/src/prng_lcg.v
  C:/Users/David/Desktop/KeyGen-2/src/prng_lcg_tb.v
  C:/Users/David/Desktop/KeyGen-2/src/mul_ctrl.v
  C:/Users/David/Desktop/KeyGen-2/src/BIKE_2_top.v
  C:/Users/David/Desktop/KeyGen-2/src/BIKE_2_top_tb.v
  C:/Users/David/Desktop/KeyGen-2/src/h0_ctrl.v
  C:/Users/David/Desktop/KeyGen-2/src/h1_ctrl.v
  C:/Users/David/Desktop/KeyGen-2/src/sparse2dense.v
  C:/Users/David/Desktop/KeyGen-2/src/blk_mul.v
  C:/Users/David/Desktop/KeyGen-2/src/blk_mul_tb.v
  C:/Users/David/Desktop/KeyGen-2/src/inv_ctrl.v
  C:/Users/David/Desktop/KeyGen-2/src/exp_ctrl.v
  C:/Users/David/Desktop/KeyGen-2/src/dsn_mul_ctrl.v
}
read_ip -quiet C:/Users/David/Desktop/KeyGen-2/KeyGen.ip/mem_g/mem_g.xci
set_property used_in_implementation false [get_files -all c:/Users/David/Desktop/KeyGen-2/KeyGen.ip/mem_g/mem_g_ooc.xdc]

read_ip -quiet C:/Users/David/Desktop/KeyGen-2/KeyGen.ip/mem_h/mem_h.xci
set_property used_in_implementation false [get_files -all c:/Users/David/Desktop/KeyGen-2/KeyGen.ip/mem_h/mem_h_ooc.xdc]

read_ip -quiet C:/Users/David/Desktop/KeyGen-2/KeyGen.ip/mul_64bit/mul_64bit/mul_64bit.xci
set_property used_in_implementation false [get_files -all c:/Users/David/Desktop/KeyGen-2/KeyGen.ip/mul_64bit/mul_64bit/mul_64bit_ooc.xdc]

read_ip -quiet C:/Users/David/Desktop/KeyGen-2/KeyGen.ip/fifo_rng/fifo_rng.xci
set_property used_in_implementation false [get_files -all c:/Users/David/Desktop/KeyGen-2/KeyGen.ip/fifo_rng/fifo_rng.xdc]
set_property used_in_implementation false [get_files -all c:/Users/David/Desktop/KeyGen-2/KeyGen.ip/fifo_rng/fifo_rng_ooc.xdc]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc C:/Users/David/Desktop/KeyGen-2/KeyGen.srcs/constrs_1/new/user_constrains.xdc
set_property used_in_implementation false [get_files C:/Users/David/Desktop/KeyGen-2/KeyGen.srcs/constrs_1/new/user_constrains.xdc]

set_param ips.enableIPCacheLiteLoad 0
close [open __synthesis_is_running__ w]

synth_design -top BIKE_2_top -part xc7a75tfgg484-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef BIKE_2_top.dcp
create_report "synth_6_synth_report_utilization_0" "report_utilization -file BIKE_2_top_utilization_synth.rpt -pb BIKE_2_top_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
