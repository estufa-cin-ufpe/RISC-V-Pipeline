#==============================================================================
#                      D E S I G N    P A R A M E T E R S
#==============================================================================
#
#
#
set PROJECT_NAME                "112L-RISCV"
set TOP                         "riscv"
set FILES                       "files_riscv"
set clock_period                4

#==============================================================================
#                  D I R E C T O R Y   S T R U C T U R E
#==============================================================================
#
set synopsys_path                       [getenv "SYNOPSYS"]
set DESIGN                              $env(design)
set design                              $env(design)
set SOURCE                              "${DESIGN}"
set SCRIPTS                             "${PROJECT_NAME}/scripts"
set DBDIR                               "${PROJECT_NAME}/db"
set NETLIST                             "${PROJECT_NAME}/netlist"
set LOG                                 "${PROJECT_NAME}/log"
set REPORTS                             "${PROJECT_NAME}/reports"



if { ![file exists $NETLIST] || ![file isdirectory $NETLIST] } {
        file mkdir $NETLIST;
}

if { ![file exists $REPORTS] || ![file isdirectory $REPORTS] } {
        file mkdir $REPORTS;
}

if { ![file exists $LOG] || ![file isdirectory $LOG] } {
        file mkdir $LOG;
}

if { ![file exists $DBDIR] || ![file isdirectory $DBDIR] } {
        file mkdir $DBDIR;
}


#==============================================================================
#                       S E T U P    L I B R A R I E S
#==============================================================================
#
set LVT_TSMCHOME "/users/ugrad2/2012/spring/pooriam/libraries/"

set TECH_LIB_PATH_LVT_1P05_N40  "$LVT_TSMCHOME/saed32lvt_tt1p05vn40c.db"
set TECH_LIB_PATH  $TECH_LIB_PATH_LVT_1P05_N40;  
set MEM_LIB_LVT_1P05_N40    "saed32sram_tt1p05vn40c"
set TECH_LIB $TECH_LIB_PATH_LVT_1P05_N40;  
set MEM_LIB $MEM_LIB_LVT_1P05_N40;  
set DRIVE_CELL BUFFD12BWP12TLVT; 
set WC_OP_CONDS WCZ0D81COM;


set search_path [list . [format "%s%s"  $synopsys_path "/libraries/syn"] \
                        [format "%s%s"  $synopsys_path "/packages"] \
                        [format "%s%s"  $synopsys_path "/packages/IEEE"] \
                                                        ${LVT_TSMCHOME}         \
                                                        ${DESIGN}         \
/ecelib/linware/synopsys15/dc/packages/IEEE/src/ \
                                                ]

set search_path "$search_path ${SOURCE} ${DBDIR} ./"

set link_library   "* $TECH_LIB_PATH $MEM_LIB_LVT_1P05_N40"
set target_library   "$TECH_LIB_PATH "
set symbol_library   "generic.sdb "

set WIRELOAD_MODEL "tcForQA"

set_app_var synthetic_library dw_foundation.sldb
set_app_var link_library "* $link_library $target_library $synthetic_library"


#==============================================================================
#                        R E A D I N G   D E S I G N
#==============================================================================

define_design_lib WORK -path ./WORK
#
source scripts/${FILES}.tcl -v -e  > ${LOG}/files_${TOP}.log


#==============================================================================
##     E L B O R A T I N G    A N D    O P T I M I Z I N G     D E S I G N S
##==============================================================================
#
elaborate ${TOP}  > ${REPORTS}/${TOP}.elab.rpt
current_design ${TOP}





#==============================================================================
#                      S Y N T H E S I S    C O N S T R A I N T S
#==============================================================================

set CORE_CLK_PERIOD            ${clock_period}
set CLK_NAME                       clk
set INPUT_DELAY                    2.0
set OUTPUT_DELAY                   0.5
set MAX_AREA                       0; # Optimize the design for the smallest possible size
set CLK_SKEW                       0.14
set MAX_OUTPUT_LOAD                0
#==============================================================================
#                       D E F I N E    C L O C K    P E R I O D S
#==============================================================================


create_clock -name $CLK_NAME    -period $CORE_CLK_PERIOD  -waveform  "0 [expr $CORE_CLK_PERIOD/2]"  [get_ports clk]

#set_clock_uncertainty $CLK_SKEW [get_clocks $CLK_NAME]

#set_input_delay  $INPUT_DELAY  -max -clock $CLK_NAME [remove_from_collection [all_inputs] $CLK_PORT]

#set_output_delay $OUTPUT_DELAY -max -clock $CLK_NAME [all_outputs]

#set_max_area $MAX_AREA

#set_driving_cell -lib_cell $DRIVE_CELL -pin $DRIVE_PIN [remove_from_collection [all_inputs] $CLK_PORT]

#set_load  $MAX_OUTPUT_LOAD [all_outputs]

#set_clock_uncertainty $CLK_SKEW [get_clocks $CLK_NAME]

#set_clock_latency     0.2  [all_clocks]

set_clock_transition 0 $CLK_NAME




puts "Linking"
redirect -tee -file ${REPORTS}/${TOP}.link.rpt  {link}

#puts "Uniquifying"
#redirect -tee -file ${REPORTS}/${TOP}.uniquify.rpt { uniquify };


redirect -tee -file ${REPORTS}/${TOP}.compile.rpt     { compile_ultra };


#==============================================================================
#                 W R I T E   O U T   D E S I G N
#==============================================================================
#

write   -format verilog -hierarchy -output  ${NETLIST}/${TOP}.vg

#==============================================================================
#                 G E N E R A T E    F I N A L    R E P O R T S
#==============================================================================
#
#

redirect -tee -file ${REPORTS}/${TOP}.qor.rpt           { report_qor }
redirect -file ${REPORTS}/${TOP}.units.rpt { report_units  }
redirect -file ${REPORTS}/${TOP}.design.rpt { report_design -nosplit }

redirect -file ${REPORTS}/${TOP}.area.rpt { report_area -nosplit -designware -hierarchy -physical -nosplit }

redirect -file ${REPORTS}/${TOP}.power_hier.rpt { \
        report_power -analysis_effort medium -verbose -nosplit -hierarchy \
}

redirect -file ${REPORTS}/${TOP}.power_flat.rpt { \
        report_power -net -cell -analysis_effort medium -verbose -nosplit -flat \
}


# clean up
#exec rm -rf *.syn *.mr *.pvl



exit





