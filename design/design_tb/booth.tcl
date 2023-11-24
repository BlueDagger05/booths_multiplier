# you can give any part number as per the need
start_gui
create_project booths_multiplier ./booths_multiplier 
# move whole folder to desired folder where you want to create project
import_files -norecurse {./sources/alu_addSub.v ./sources/controlPath.v ./sources/dataPath.v ./sources/counter15.v ./sources/dff_async_clear.v ./sources/masterrst.v ./sources/pipo_register.v ./sources/shift_register.v ./sources/top_booth_multiplier.v}
update_compile_order -fileset sources_1
set_property top top_booth_multiplier [current_fileset]
import_files -fileset sim_1 {./tb/tb_dataPath.sv}
set_property top tb_dataPath [current_fileset sim_1]
update_compile_order -fileset sim_1
synth_design -rtl -rtl_skip_mlo -name rtl_1
