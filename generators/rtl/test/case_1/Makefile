simv_name = simv
src = file.list

VCS_OPS = -full64 -sverilog +v2k -timescale=1ns/1ns  \
		-debug_acc+all                                  \
		+warn=all                                       \
		+notimingcheck                                  \
		-kdb                                            \
		+nospecify                                      \
		+vcs+flush+all                                  \
		-o $(simv_name)                                 \
		-f $(src)

# verdi dump wave compile option
VERDI_OPS = -P $(NOVAS_HOME)/share/PLI/VCS/linux64/novas.tab \
			$(NOVAS_HOME)/share/PLI/VCS/linux64/pli.a \
			+fsdb+autoflush


vcs: $(src)
	bsub -Is vcs $(VCS_OPS) $(src) $(VERDI_OPS)

sim: vcs
	./$(simv_name)

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