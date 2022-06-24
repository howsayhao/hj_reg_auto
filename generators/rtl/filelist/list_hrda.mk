$(call declare-mod,hrda)
$(call add,ihdr,hrda,$(sop_base)/rtl/hrda/xregister.vh)
$(call add,mod,hrda,common_funcs)
$(call add,mod,hrda,bridge cdc field fsm mux sim snapshot)

$(call declare-mod,bridge)
$(call add,rtl,bridge,$(sop_base)/rtl/hrda/bridge/apb2reg_native_if.v \
	$(sop_base)/rtl/hrda/bridge/reg_native_if2apb.v \
	$(sop_base)/rtl/hrda/bridge/reg_native_if2mem.v \
	$(sop_base)/rtl/hrda/bridge/reg_native_if2third_party_ip.v)

$(call declare-mod,cdc)
$(call add,rtl,cdc,$(sop_base)/rtl/hrda/cdc/value_transmitter.v)
$(call add,mod,cdc,value_deliver pulse_deliver)

$(call declare-mod,field)
$(call add,rtl,field,$(sop_base)/rtl/hrda/hw_ctrl.v \
	$(sop_base)/rtl/hrda/sw_ctrl.v \
	$(sop_base)/rtl/hrda/field.v)

$(call declare-mod,fsm)
$(call add,rtl,fsm,$(sop_base)/rtl/hrda/mst_fsm.v \
	$(sop_base)/rtl/hrda/slv_fsm.v)

$(call declare-mod,mux)
$(call add,mod,mux,priority_mux one_hot_mux split_mux_2d)

$(call declare-mod,sim)
$(call add,rtl,sim,$(sop_base)/rtl/hrda/sim/ext_mem.v)

$(call declare-mod,snapshot)
$(call add,rtl,snapshot,$(sop_base)/rtl/hrda/snapshot/snapshot_mem.v \
	$(sop_base)/rtl/hrda/snapshot/snapshot_reg.v)