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
   cv.gif     \
   svpvfm.gif \
   io.gif     \
   ook.gif    \
   flags.gif  \
   types.gif

%.eps: %.epsx Makefile epsx2eps sv.ps common.ps mws.ps box.ps str.ps ptr.ps magic.ps arrow.ps chararray.ps gp.ps
	./epsx2eps $< >$@

%.gif: %.eps
	./eps2gif $< >$@

clean:
	rm -f *.eps *.gif *~
