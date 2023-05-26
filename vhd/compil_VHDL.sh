vdel -lib  ${PATH_WORK}/libs/lib_VHDL -all
vlib ${PATH_WORK}/libs/lib_VHDL
vmap lib_VHDL ${PATH_WORK}/libs/lib_VHDL 
vcom -work lib_VHDL my_type.vhd
vcom -work lib_VHDL BARREL_SHIFTER.vhd
vcom -work lib_VHDL ULA.vhd
vcom -work lib_VHDL BANK_REG.vhd 
vcom -work lib_VHDL LOGIC_PC.vhd
vcom -work lib_VHDL TEST_COND.vhd
vcom -work lib_VHDL SEL_REGS.vhd
vcom -work lib_VHDL MUL.vhd
vcom -work lib_VHDL ZERO_FILL.vhd
vcom -work lib_VHDL MEM_DONNEE.vhd
vcom -work lib_VHDL DECODEUR.vhd
vcom -work lib_VHDL DATAPATH.vhd
vcom -work lib_VHDL DECODAGE.vhd
vcom -work lib_VHDL FETCH.vhd
vcom -work lib_VHDL ARM.vhd

