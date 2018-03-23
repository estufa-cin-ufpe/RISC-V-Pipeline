
setenv PATH /home/linware/mentor/questa/questasim/:/home/linware/mentor/questa/questasim/bin/:$PATH

setenv LM_LICENSE_FILE 1717@zuma.eecs.uci.edu
setenv MGLS_LICENSE_FILE 1717@zuma.eecs.uci.edu

setenv LD_LIBRARY_PATH /home/linware/mentor/questa/questasim/lib/:/home/linware/mentor/questa/questasim/
setenv MGC_HOME /home/linware/mentor/questa/questasim/
setenv MODEL_TECH /home/linware/mentor/questa/questasim/bin
setenv QUESTA_HOME /home/linware/mentor/questa/questasim/
setenv QUESTA_UVM_HOME $QUESTA_HOME/verilog_src/questa_uvm_pkg-1.2
setenv UVM_HOME $QUESTA_HOME/verilog_src/uvm-1.1d

source /ecelib/linware/synopsys15/env/dc.csh

cd ..
setenv sim `pwd`/sim
setenv syn `pwd`/syn

setenv design `pwd`/design
setenv model `pwd`/model
setenv verif `pwd`/verif

cd $sim

