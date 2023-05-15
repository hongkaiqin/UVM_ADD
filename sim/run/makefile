
TESTNAME ?= order_data_add_test

COV?=0
ifeq (${COV},1)
  COV_COMP_OPT= -cm line+cond+fsm+branch+tgl -cm_dir ./coverage/sim_${TESTNAME}.vdb -cm_hier ./cov.cfg
  COV_SIM_OPT= -cm line+cond+fsm+branch+tgl -cm_dir ./coverage/sim_${TESTNAME}.vdb -cm_name ${TESTNAME}
else
  COV_COMP_OPT=
  COV_SIM_OPT=
endif

INC_DIR =  +incdir+../tb/interface
INC_DIR += +incdir+../tb/env
INC_DIR += +incdir+../tb/seq
INC_DIR += +incdir+../tb/tests
INC_DIR += +incdir+../tb/top

seed = $(shell date +%H%M%S)

all:comp sim

comp:
	-mkdir -m 777 ${TESTNAME}_sim_dir
	vcs -full64 -sverilog -kdb -q -debug_access+all -ntb_opts uvm -timescale=1ns/1ns \
	${COV_COMP_OPT} ${INC_DIR} +define+DUMP_FSDB=1 \
	-l ${TESTNAME}_sim_dir/comp_${TESTNAME}.log \
	-f ../tb/top/rtl.f \
	-top tb_top ../tb/top/tb_top.sv
	@echo "***********************************************"
	@echo "Compile finished."
	@echo "Compile log: ${TESTNAME}_sim_dir/comp_${TESTNAME}.log"
	@echo "***********************************************"

sim:
	-mkdir ${TESTNAME}_sim_dir
	./simv ${COV_SIM_OPT} -l ${TESTNAME}_sim_dir/sim_${TESTNAME}.log +ntb_random_seed=${seed} \
	+TESTNAME=${TESTNAME} +UVM_TESTNAME=${TESTNAME}
	@echo "***********************************************"
	@echo "Simulation finished."
	@echo "Simulation log: ${TESTNAME}_sim_dir/sim_${TESTNAME}.log"
	@echo "***********************************************"

verdi:
	verdi -ssf tb.fsdb -simflow -simBin ./simv &

merge.vdb:
	urg -full64 -format both -dir ./coverage/*.vdb -dbname merge.vdb

cov: merge.vdb
	firefox urgReport/dashboard.html &
	verdi -cov -covdir merge.vdb &

.PHONY: clean cleanall
clean:
	rm -rf csrc simv simv.* *.fsdb .__solver_cache__
	rm -rf novas* ucli.key vc_hdrs.h

cleanall:clean
	rm -rf coverage merge.vdb urgReport vdCovLog
	rm -rf verdiLog *.log *_sim_dir
