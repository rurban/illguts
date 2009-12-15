png=svhead.png \
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
   sv_u.png   \
   flags.png  \
   svtypes.png\
   optypes.png\
   op1.png    \
   op2.png    \
   stack.png  \
   scope.png  \
   pad.png

png: $(png)

all: illguts.chm $(png) slides

illguts.chm: index.html illguts.hhp illguts.hhk $(png)
	-hhc illguts.hhp

slides: slides/index.html

slides/index.html: slides.pds index.html
	./mk-slides slides.pds

eps:
	for x in *.png; do s=$${x/.png/.eps}; make $s; done

%.eps: %.epsx epsx2eps sv.ps common.ps mws.ps box.ps str.ps ptr.ps magic.ps arrow.ps chararray.ps gp.ps stash.ps glob.ps op.ps dist.ps
	./epsx2eps $< >$@

%.png: %.epsx
	./epsx2eps $< >$@.eps
	./eps2png $@.eps >$@
	rm $@.eps

clean:
	rm -f *.eps *~

dist: all VERSION
	./make_dist

# deps
av.png: av.epsx common.ps sv.ps rect.ps ptr.ps box.ps mws.ps break.ps
cv.png: cv.epsx common.ps sv.ps rect.ps ptr.ps box.ps mws.ps magic.ps
flags.png: flags.epsx common.ps mws.ps rect.ps
gv.png: gv.epsx common.ps sv.ps rect.ps ptr.ps box.ps mws.ps gp.ps chararray.ps
hv.png: hv.epsx common.ps sv.ps rect.ps ptr.ps box.ps mws.ps he.ps chararray.ps break.ps
io.png: io.epsx common.ps sv.ps rect.ps ptr.ps box.ps mws.ps magic.ps
ook.png: ook.epsx common.ps sv.ps rect.ps ptr.ps box.ps break.ps
op1.png: op1.epsx common.ps box.ps rect.ps mws.ps op.ps
op2.png: op2.epsx common.ps box.ps rect.ps mws.ps op.ps
optypes.png: optypes.epsx common.ps arrow.ps
pad.png: pad.epsx common.ps sv.ps rect.ps ptr.ps box.ps mws.ps break.ps
scope.png: scope.epsx common.ps rect.ps ptr.ps break.ps dist.ps sv.ps
stack.png: stack.epsx common.ps rect.ps ptr.ps break.ps dist.ps sv.ps box.ps mws.ps
stash.png: stash.epsx common.ps stash.ps rect.ps ptr.ps box.ps glob.ps mws.ps sv.ps
strtab.png: strtab.epsx common.ps box.ps rect.ps mws.ps ptr.ps sv.ps
sv_u.png: sv_u.epsx common.ps mws.ps rect.ps
svhead.png: svhead.epsx common.ps mws.ps rect.ps
sviv.png: sviv.epsx common.ps sv.ps rect.ps ptr.ps box.ps
svnull.png: svnull.epsx common.ps mws.ps rect.ps
svnv.png: svnv.epsx common.ps sv.ps rect.ps ptr.ps box.ps
svpv.png: svpv.epsx common.ps sv.ps rect.ps ptr.ps box.ps str.ps break.ps
svpvbm.png: svpvbm.epsx common.ps sv.ps rect.ps ptr.ps box.ps mws.ps magic.ps break.ps
svpvfm.png: svpvfm.epsx common.ps sv.ps rect.ps ptr.ps box.ps mws.ps break.ps
svpviv.png: svpviv.epsx common.ps sv.ps rect.ps ptr.ps box.ps str.ps break.ps
svpvlv.png: svpvlv.epsx common.ps sv.ps rect.ps ptr.ps box.ps mws.ps magic.ps
svpvmg.png: svpvmg.epsx common.ps sv.ps rect.ps ptr.ps box.ps mws.ps magic.ps chararray.ps
svpvnv.png: svpvnv.epsx common.ps sv.ps rect.ps ptr.ps box.ps str.ps break.ps
svpvrv.png: svpvrv.epsx common.ps sv.ps rect.ps ptr.ps box.ps
svrv.png: svrv.epsx common.ps sv.ps rect.ps ptr.ps box.ps
svtypes.png: svtypes.epsx common.ps arrow.ps
