$(call declare-mod,root_map)
$(call add,rtl,root_map, \
    $(ROOT_MAP_DIR)/rtl/regmst_root_map.v \
    $(ROOT_MAP_DIR)/rtl/regdisp_disp_map.v \
    $(ROOT_MAP_DIR)/rtl/regslv_slv_map.v)

$(call add,mod,root_map,hrda)