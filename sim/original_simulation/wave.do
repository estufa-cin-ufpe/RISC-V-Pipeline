onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_top/reset
add wave -noupdate /tb_top/tb_clk
add wave -noupdate /tb_top/riscV/dp/instr_mem/rd
add wave -noupdate /tb_top/tb_WB_Data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {232902 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 198
configure wave -valuecolwidth 40
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {209035 ps}
