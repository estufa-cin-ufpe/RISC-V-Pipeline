rm -rf modelsim.ini
rm -rf questa
vlib questa
vlib questa/work
#vmap work questa/work
#vlib questa/work
vmap -c mtiUvm questa/work
#vmap work questa/work
#vlog +incdir+$UVM_HOME/src $UVM_HOME/src/uvm_pkg.sv $UVM_HOME/src/dpi/uvm_dpi.cc
#vlog +incdir+$UVM_HOME/src +incdir+$QUESTA_UVM_HOME/src $QUESTA_UVM_HOME/src/questa_uvm_pkg.sv

