simv_name = simv
rtl_src = file.list
rdl_src = tb/testbench.rdl

VCS_OPS = -full64 -sverilog +v2k -timescale=1ns/1ps     \
		-debug_acc+all                                  \
		+warn=all                                       \
		+notimingcheck                                  \
		-kdb                                            \
		+nospecify                                      \
		+vcs+flush+all                                  \
		-o $(simv_name)                                 \
		-f $(rtl_src)

# verdi dump wave compile option
VERDI_OPS = -P $(VERDI_HOME)/share/PLI/VCS/linux64/novas.tab \
			$(VERDI_HOME)/share/PLI/VCS/linux64/pli.a \
			+fsdb+autoflush


gen_rtl: $(rdl_src)
	rm -rf ./gen && mkdir gen
	hrda generate -f $(rdl_src) -gdir ./gen -grtl
	mv ./gen/rtl/* ./gen && rm -rf ./gen/rtl

vcs: $(rtl_src)
	bsub -Is vcs $(VCS_OPS) $(VERDI_OPS)

sim: vcs
	./$(simv_name)

verdi: sim $(rtl_src)
	bsub -Is verdi -sv -f $(rtl_src) -ssf *.fsdb

.PHONY: clean
clean:
	rm -rf *csrc
	rm -rf ./*.daidir
	rm -rf *fsdb*
	rm -rf $(simv_name)
	rm -rf *simv* DVE* ucli* *.vpd *.vdb
	rm -rf *.log *.fsdb *novas* *.dat *Log *rc *conf* core*