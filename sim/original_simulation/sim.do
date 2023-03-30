#set PathSeparator .

set WLFFilename waveform.wlf

set WildcardFilter {}

log -r tb_top/riscV/dp/rf/register_file

log -r /*


#log -r /* 
run -all
quit
