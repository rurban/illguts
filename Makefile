all: \
   svnull.gif \
   svrv.gif   \
   sviv.gif   \
   svnv.gif   \
   svpv.gif   \
   svpviv.gif \
   svpvnv.gif \
   svpvmg.gif \
   svpvbm.gif \
   svpvlv.gif \
   svpvrv.gif \
   av.gif     \
   hv.gif     \
   strtab.gif \
   gv.gif     \
   stash.gif  \
   cv.gif     \
   svpvfm.gif \
   io.gif     \
   ook.gif    \
   flags.gif  \
   svtypes.gif\
   optypes.gif\
   op1.gif    \
   op2.gif    \
   stack.gif  \
   scope.gif  \


%.eps: %.epsx Makefile epsx2eps sv.ps common.ps mws.ps box.ps str.ps ptr.ps magic.ps arrow.ps chararray.ps gp.ps stash.ps glob.ps op.ps dist.ps
	./epsx2eps $< >$@

%.gif: %.eps
	./eps2gif $< >$@

clean:
	rm -f *.eps *.gif *~

dist: all VERSION
	./make_dist
