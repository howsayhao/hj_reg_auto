simv_name = simv
src = xregister.vh common_funcs.vh \
	dw/right_find_1st_one.v  dw/one_hot_mux.v dw/one_hot_mux_ff.v \
	dw/one_hot_mux_2d.v dw/split_mux.v dw/split_mux_2d.v \
	dw/priority_mux.v dw/priority_mux_2d.v \
	field.v sw_ctrl.v hw_ctrl.v \
	slv_fsm.v regslv_regslv_test_inst.v \
	ext_mem_32_64.v regslv_tb.v

VCS_OPS = -R -full64 -sverilog +v2k -timescale=1ns/1ns  \
		-debug_acc+all                                  \
		+warn=none                                      \
		+notimingcheck                                  \
		-kdb											\
		+nospecify                                      \
		+vcs+flush+all                                  \
		-o $(simv_name)

# verdi dump wave compile option
VERDI_OPS = -P ${NOVAS_HOME}/share/PLI/VCS/linux64/novas.tab \
			${NOVAS_HOME}/share/PLI/VCS/linux64/pli.a \
			+fsdb+autoflush

sim: $(simv_name)
	./$(simv_name)

dve: $(src)
	bsub -Is vcs $(VCS_OPS) $(src) -gui

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