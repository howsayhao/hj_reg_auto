$(call declare-mod,hrda)
$(call add,mhdl_ib_path,hrda,$(sop_base)/rtl/hrda)
$(call add,mhdl_incdir,hrda,$(sop_base)/rtl/hrda)
$(call add,mod,hrda,hrda_field hrda_bridge hrda_fsm hrda_snapshot)
$(call add,mod,hrda,split_mux_2d)
$(call add,core_name,hrda,hj:naqu:hrda:0.0.0)
$(call add,core_file,hrda,$(sop_base)/hrda.core)

# --------------------------------------------------------------------------------------
# field components
# --------------------------------------------------------------------------------------
$(call declare-mod,field_attr)
$(call add,idir,field_attr,$(sop_base)/rtl/hrda)
$(call add,ihdr,field_attr,$(sop_base)/rtl/hrda/field_attr.vh)

$(call declare-mod,sw_ctrl)
$(call add,rtl,sw_ctrl,$(sop_base)/rtl/hrda/field/sw_ctrl.v)
$(call add,mod,sw_ctrl,field_attr priority_mux)

$(call declare-mod,hw_ctrl)
$(call add,rtl,hw_ctrl,$(sop_base)/rtl/hrda/field/hw_ctrl.v)
$(call add,mod,hw_ctrl,field_attr)

$(call declare-mod,field)
$(call add,rtl,field,$(sop_base)/rtl/hrda/field/field.v)
$(call add,mod,field,field_attr sw_ctrl hw_ctrl priority_mux)

$(call declare-mod,hrda_field)
$(call add,mod,hrda_field,field)

# --------------------------------------------------------------------------------------
# bridge components
# --------------------------------------------------------------------------------------
$(call declare-mod,apb2reg_native_if)
$(call add,rtl,apb2reg_native_if,$(sop_base)/rtl/hrda/bridge/apb2reg_native_if.v)

$(call declare-mod,reg_native_if2apb)
$(call add,rtl,reg_native_if2apb,$(sop_base)/rtl/hrda/bridge/reg_native_if2apb.v)

$(call declare-mod,reg_native_if2mem)
$(call add,rtl,reg_native_if2mem,$(sop_base)/rtl/hrda/bridge/reg_native_if2mem.v)
$(call add,mod,reg_native_if2mem,value_deliver pulse_deliver snapshot_mem)

$(call declare-mod,reg_native_if2third_party_ip)
$(call add,rtl,reg_native_if2third_party_ip,$(sop_base)/rtl/hrda/bridge/reg_native_if2third_party_ip.v)
$(call add,mod,reg_native_if2third_party_ip,value_deliver_1cycle)

$(call declare-mod,reg_native_if_1to1)
$(call add,rtl,reg_native_if_1to1,$(sop_base)/rtl/hrda/bridge/reg_native_if_1to1.v)
$(call add,mod,reg_native_if_1to1,value_deliver_1cycle)

$(call declare-mod,hrda_bridge)
$(call add,mod,hrda_bridge,apb2reg_native_if reg_native_if2apb reg_native_if2mem reg_native_if2third_party_ip reg_native_if_1to1)

# --------------------------------------------------------------------------------------
# fsm components
# --------------------------------------------------------------------------------------
$(call declare-mod,mst_fsm)
$(call add,rtl,mst_fsm,$(sop_base)/rtl/hrda/fsm/mst_fsm.v)

$(call declare-mod,slv_fsm)
$(call add,rtl,slv_fsm,$(sop_base)/rtl/hrda/fsm/slv_fsm.v)

$(call declare-mod,hrda_fsm)
$(call add,mod,hrda_fsm,mst_fsm slv_fsm)

# --------------------------------------------------------------------------------------
# snapshot components
# --------------------------------------------------------------------------------------
$(call declare-mod,snapshot_mem)
$(call add,mod,snapshot_mem,common_funcs one_hot_mux)
$(call add,rtl,snapshot_mem,$(sop_base)/rtl/hrda/snapshot/snapshot_mem.v)

$(call declare-mod,snapshot_reg)
$(call add,mod,snapshot_reg,common_funcs)
$(call add,rtl,snapshot_reg,$(sop_base)/rtl/hrda/snapshot/snapshot_reg.v)

$(call declare-mod,hrda_snapshot)
$(call add,mod,hrda_snapshot,snapshot_mem snapshot_reg)