$(call declare-mod,hrda)
$(call add,mod,hrda,hrda_bridge hrda_cdc hrda_field hrda_fsm hrda_sim hrda_snapshot)
$(call add,mod,hrda,split_mux_2d)

$(call declare-mod,field_attr)
$(call add,idir,field_attr,$(sop_base)/rtl/hrda)
$(call add,ihdr,field_attr,$(sop_base)/rtl/hrda/field_attr.vh)

$(call declare-mod,hrda_bridge)
$(call add,rtl,hrda_bridge,$(sop_base)/rtl/hrda/bridge/apb2reg_native_if.v \
	$(sop_base)/rtl/hrda/bridge/reg_native_if2apb.v \
	$(sop_base)/rtl/hrda/bridge/reg_native_if2mem.v \
	$(sop_base)/rtl/hrda/bridge/reg_native_if2third_party_ip.v)
$(call add,mod,hrda_bridge,hrda_snapshot)

$(call declare-mod,hrda_cdc)
$(call add,rtl,hrda_cdc,$(sop_base)/rtl/hrda/cdc/value_transmitter.v)
$(call add,mod,hrda_cdc,value_deliver pulse_deliver)

$(call declare-mod,hrda_field)
$(call add,mod,hrda_field,field_attr)
$(call add,rtl,hrda_field,$(sop_base)/rtl/hrda/field/hw_ctrl.v \
	$(sop_base)/rtl/hrda/field/sw_ctrl.v \
	$(sop_base)/rtl/hrda/field/field.v)
$(call add,mod,hrda_field,priority_mux)

$(call declare-mod,hrda_fsm)
$(call add,rtl,hrda_fsm,$(sop_base)/rtl/hrda/fsm/mst_fsm.v \
	$(sop_base)/rtl/hrda/fsm/slv_fsm.v)

$(call declare-mod,hrda_sim)
$(call add,rtl,hrda_sim,$(sop_base)/rtl/hrda/sim/ext_mem.v)

$(call declare-mod,hrda_snapshot)
$(call add,mod,hrda_snapshot,common_funcs)
$(call add,mod,hrda_snapshot,field_attr)
$(call add,rtl,hrda_snapshot,$(sop_base)/rtl/hrda/snapshot/snapshot_mem.v \
	$(sop_base)/rtl/hrda/snapshot/snapshot_reg.v)
$(call add,mod,hrda_snapshot,one_hot_mux)