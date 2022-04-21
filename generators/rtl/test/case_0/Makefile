simv_name = simv
rtl_src = file.list

regslv_tb = tb/regslv_tb.v
regmst_tb = tb/regmst_tb.v

VCS_OPS = -full64 -sverilog +v2k -timescale=1ns/1ns  \
		-debug_acc+all                                  \
		+warn=all                                       \
		+notimingcheck                                  \
		-kdb                                            \
		+nospecify                                      \
		+vcs+flush+all                                  \
		-o $(simv_name)                                 \
		-f $(rtl_src)

# verdi dump wave compile option
VERDI_OPS = -P ${VERDI_HOME}/share/PLI/VCS/linux64/novas.tab \
			${VERDI_HOME}/share/PLI/VCS/linux64/pli.a \
			+fsdb+autoflush

vcs_regslv: $(rtl_src)
	bsub -Is vcs $(VCS_OPS) $(regslv_tb) $(VERDI_OPS)

vcs_regmst: $(rtl_src)
	bsub -Is vcs $(VCS_OPS) $(regmst_tb) $(VERDI_OPS)

sim_regslv: vcs_regslv
	./$(simv_name)

sim_regmst: vcs_regmst
	./$(simv_name)

verdi_regslv: sim_regslv $(rtl_src)
	bsub -Is verdi -sv -f $(rtl_src) $(regslv_tb) -ssf *.fsdb

verdi_regmst: sim_regmst $(rtl_src)
	bsub -Is verdi -sv -f $(rtl_src) $(regmst_tb) -ssf *.fsdb

.PHONY: clean
clean:
	rm -rf *csrc
	rm -rf ./*.daidir
	rm -rf *fsdb*
	rm -rf $(simv_name)
	rm -rf *simv* DVE* ucli* *.vpd *.vdb
	rm -rf *.log *.fsdb *novas* *.dat *Log *rc *conf* core*