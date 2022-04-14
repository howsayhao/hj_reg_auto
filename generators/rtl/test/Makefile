simv_name = simv
src = dw/right_find_1st_one.v  dw/one_hot_mux.v dw/one_hot_mux_ff.v \
	dw/one_hot_mux_2d.v dw/split_mux.v dw/split_mux_2d.v \
	dw/priority_mux.v dw/priority_mux_2d.v \
	field.v sw_ctrl.v hw_ctrl.v \
	slv_fsm.v mst_fsm.v \
	xregister.vh common_funcs.vh \
	gen/regmst_reg_top.v gen/regslv_reg_block_1.v \
	gen/regslv_reg_block_2.v gen/regslv_test_11.v \
	tb/ext_mem.v tb/regmst_tb.v

VCS_OPS = -R -full64 -sverilog +v2k -timescale=1ns/1ns  \
		-debug_acc+all                                  \
		+warn=all                                       \
		+notimingcheck                                  \
		-kdb                                            \
		+nospecify                                      \
		+vcs+flush+all                                  \
		-o $(simv_name)

# verdi dump wave compile option
VERDI_OPS = -P ${VERDI_HOME}/share/PLI/VCS/linux64/novas.tab \
			${VERDI_HOME}/share/PLI/VCS/linux64/pli.a \
			+fsdb+autoflush

sim: $(simv_name)
	./$(simv_name)

vcs: $(src)
	bsub -Is vcs $(VCS_OPS) $(src) $(VERDI_OPS)

verdi: vcs $(src)
	bsub -Is verdi -sv $(src) -ssf *.fsdb

.PHONY: clean
clean:
	rm -rf *csrc
	rm -rf ./*.daidir
	rm -rf *fsdb*
	rm -rf $(simv_name)
	rm -rf *simv* DVE* ucli* *.vpd *.vdb
	rm -rf *.log *.fsdb *novas* *.dat *Log *rc *conf* core*