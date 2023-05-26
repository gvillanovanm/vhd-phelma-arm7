vdel -lib  ${PATH_WORK}/libs/lib_BENCH -all
vlib ${PATH_WORK}/libs/lib_BENCH
vmap lib_BENCH ${PATH_WORK}/libs/lib_BENCH 
vcom -work lib_VHDL ${PATH_WORK}/vhd/FETCH.vhd
vcom -work lib_BENCH TB_ARM.vhd