all: \
   svnull.png \
   svrv.png   \
   sviv.png   \
   svnv.png   \
   svpv.png   \
   svpviv.png \
   svpvnv.png \
   svpvmg.png \
   svpvbm.png \
   svpvlv.png \
   svpvrv.png \
   av.png     \
   hv.png     \
   strtab.png \
   gv.png     \
   stash.png  \
   cv.png     \
   svpvfm.png \
   io.png     \
   ook.png    \
   flags.png  \
   svtypes.png\
   optypes.png\
   op1.png    \
   op2.png    \
   stack.png  \
   scope.png  \


%.eps: %.epsx Makefile epsx2eps sv.ps common.ps mws.ps box.ps str.ps ptr.ps magic.ps arrow.ps chararray.ps gp.ps stash.ps glob.ps op.ps dist.ps
	./epsx2eps $< >$@

%.png: %.eps
	./eps2png $< >$@

clean:
	rm -f *.eps *.png *~

dist: all VERSION
	./make_dist
