$(call declare-mod,root_map)
$(call add,rtl,root_map, \
    $(PROJECT_ROOT_MAP_HOME)/rtl/regdisp_root_map.v \
    $(PROJECT_ROOT_MAP_HOME)/rtl/regdisp_disp_map.v \
    $(PROJECT_ROOT_MAP_HOME)/rtl/regslv_slv_map.v \
    $(PROJECT_ROOT_MAP_HOME)/rtl/regdisp_disp1_map.v \
    $(PROJECT_ROOT_MAP_HOME)/rtl/regslv_slv1_map.v \
    $(PROJECT_ROOT_MAP_HOME)/rtl/regslv_slv4_map.v \
    $(PROJECT_ROOT_MAP_HOME)/rtl/regdisp_disp2_map.v \
    $(PROJECT_ROOT_MAP_HOME)/rtl/regslv_slv2_map.v \
    $(PROJECT_ROOT_MAP_HOME)/rtl/regdisp_disp3_map.v \
    $(PROJECT_ROOT_MAP_HOME)/rtl/regslv_slv3_map.v \
    $(PROJECT_ROOT_MAP_HOME)/rtl/regslv_slv5_map.v)

$(call add,mod,root_map,hrda)