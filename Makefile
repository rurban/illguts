# sed -i -e's,0.37,0.38,' META.yml VERSION illguts.hhp index-work.html

png=svhead.png \
   svrv.png   \
   strtab.png \
   stash.png  \
   sv_u.png   \
   flags.png  \
   svtypes.png\
   scope.png  \
   pad.png \
   optypes.png\
   op1.png    \
   op2.png    \
   opsample.png\
   opsamp2.png \
   stack.png  \
   context.png  \
   eval.png \
   arena.png

png-8=av-8.png \
  cv-8.png \
  flags-8.png \
  gv-8.png \
  hv-8.png \
  io-8.png \
  op1-8.png \
  op2-8.png \
  ook-8.png \
  scope-8.png \
  stack-8.png \
  strtab-8.png \
  stash-8.png \
  sviv-8.png \
  svnv-8.png \
  svpv-8.png \
  svpvbm-8.png \
  svpvfm-8.png \
  svpviv-8.png \
  svpvlv-8.png \
  svpvmg-8.png \
  svpvnv-8.png \
  svpvrv-8.png \
  svrv-8.png \
  svtypes-8.png \
  svhead-8.png

png-10=av-10.png \
  hv-10.png \
  io-10.png \
  cv-10.png \
  gv-10.png \
  ook-10.png \
  ook-12.png \
  sviv-10.png \
  svnv-10.png \
  svpv-10.png \
  svpvbm-10.png \
  svpvfm-10.png \
  svpviv-10.png \
  svpvlv-10.png \
  svpvmg-10.png \
  svpvnv-10.png

png-14=av-14.png \
  hv-14.png \
  gv-14.png \
  cv-14.png \
  io-14.png \
  ook-14.png \
  sviv-14.png \
  svnv-14.png \
  svpv-14.png \
  svpvbm-14.png \
  svpvfm-14.png \
  svpviv-14.png \
  svpvlv-14.png \
  svpvmg-14.png \
  svpvnv-14.png

png: $(png) $(png-8) $(png-10) $(png-14) index.html

all: $(png) index.html chm pdf slides

chm: illguts.chm

index.html: htmlprep.pl index-work.html $(png) $(png-8) $(png-10) $(png-14)
	./htmlprep.pl

index-8.html: htmlprep.pl index-work.html $(png-8)
	./htmlprep.pl

index-10.html: htmlprep.pl index-work.html $(png-10)
	./htmlprep.pl

index-12.html: htmlprep.pl index-work.html $(png-10)
	./htmlprep.pl

index-14.html: htmlprep.pl index-work.html  $(png-14)
	./htmlprep.pl

pdf: index.html illguts-8.pdf illguts-10.pdf illguts-12.pdf illguts-14.pdf illguts.pdf

illguts.pdf: index.html $(png)
	-htmldoc --quiet --webpage --format pdf14 index.html -f $@

illguts-8.pdf: index-8.html $(png)
	-htmldoc --quiet --webpage --format pdf14 index-8.html -f $@

illguts-10.pdf: index-10.html $(png)
	-htmldoc --quiet --webpage --format pdf14 index-10.html -f $@

illguts-12.pdf: index-12.html $(png)
	-htmldoc --quiet --webpage --format pdf14 index-12.html -f $@

illguts-14.pdf: index-14.html $(png)
	-htmldoc --quiet --webpage --format pdf14 index-14.html -f $@

slides: slides/index.html

illguts.chm: index.html illguts.hhp illguts.hhk $(png)
	-hhc illguts.hhp

slides/index.html: slides.pds index.html
	./mk-slides slides.pds

t/97_meta.t: META.yml

test: t/97_meta.t
	perl t/97_meta.t

test_rel: t/97_meta.t
	-#RELEASE_TESTING=1 perl t/97_meta.t

eps:
	for x in *.png; do s=$${x/.png/.eps}; make $s; done

%.eps: %.epsx epsx2eps sv.ps common.ps mws.ps box.ps str.ps ptr.ps magic.ps arrow.ps chararray.ps gp.ps stash.ps glob.ps op.ps dist.ps
	./epsx2eps $< >$@

%.png: %.epsx
	./epsx2eps $< >$@.eps
	./eps2png $@.eps >$@.tmp
	@test -s $@.tmp || rm $@.tmp
	@test -s $@.tmp && mv $@.tmp $@
	rm $@.eps

clean:
	rm -f *.eps *~

dist: all VERSION test_rel
	./make_dist

# deps
arena.png: sv.ps box.ps
av-8.png:  av-8.epsx sv-8.ps common.ps rect.ps ptr.ps box.ps mws.ps break.ps
av-10.png: av-10.epsx sv.ps common.ps rect.ps ptr.ps box.ps mws.ps break.ps
av-14.png: av-14.epsx sv.ps common.ps rect.ps ptr.ps box.ps mws.ps break.ps
cv-8.png:  cv-8.epsx sv-8.ps common.ps rect.ps ptr.ps box.ps mws.ps magic.ps pad.ps
cv-10.png: cv-10.epsx sv.ps common.ps rect.ps ptr.ps box.ps mws.ps magic-10.ps pad.ps
cv-14.png: cv-14.epsx sv.ps common.ps rect.ps ptr.ps box.ps mws.ps magic-10.ps pad.ps
flags-8.png: flags-8.epsx common.ps mws.ps rect.ps
flags.png: flags.epsx common.ps mws.ps rect.ps
gv-8.png:  gv-8.epsx sv-8.ps common.ps rect.ps ptr.ps box.ps mws.ps gp-8.ps chararray.ps
gv-10.png: gv-10.epsx sv.ps common.ps rect.ps ptr.ps box.ps mws.ps gp.ps he.ps
gv-14.png: gv-14.epsx sv.ps common.ps rect.ps ptr.ps box.ps mws.ps gp.ps he.ps
hv-8.png:  hv-8.epsx sv-8.ps common.ps rect.ps ptr.ps box.ps mws.ps he-8.ps chararray.ps break.ps
hv-10.png: hv-10.epsx sv.ps common.ps rect.ps ptr.ps box.ps mws.ps he.ps chararray.ps break.ps
hv-14.png: hv-14.epsx sv.ps common.ps rect.ps ptr.ps box.ps mws.ps he.ps chararray.ps break.ps
io-8.png: io-8.epsx sv-8.ps common.ps rect.ps ptr.ps box.ps mws.ps magic.ps
io-10.png: io-10.epsx sv.ps common.ps rect.ps ptr.ps box.ps mws.ps magic-10.ps
io-14.png: io-14.epsx sv.ps common.ps rect.ps ptr.ps box.ps mws.ps magic-10.ps
ook-8.png: ook-8.epsx sv-8.ps common.ps rect.ps ptr.ps box.ps break.ps
ook-10.png: ook-10.epsx sv.ps common.ps rect.ps ptr.ps box.ps break.ps
ook-12.png: ook-12.epsx sv.ps common.ps rect.ps ptr.ps box.ps break.ps
ook-14.png: ook-14.epsx sv.ps common.ps rect.ps ptr.ps box.ps break.ps
op1.png: op1.epsx common.ps box.ps rect.ps mws.ps op.ps
op1-8.png: op1-8.epsx common.ps box.ps rect.ps mws.ps op-8.ps
op2.png: op2.epsx common.ps box.ps rect.ps mws.ps op.ps
op2-8.png: op2-8.epsx common.ps box.ps rect.ps mws.ps op-8.ps
optypes.png: optypes.epsx common.ps arrow.ps
opsample.png: opsample.epsx common.ps ptr.ps
opsamp2.png: opsamp2.epsx common.ps ptr.ps
pad.png: pad.epsx sv.ps common.ps rect.ps ptr.ps box.ps mws.ps break.ps pad.ps
scope.png: scope.epsx common.ps rect.ps ptr.ps break.ps dist.ps sv.ps
scope-8.png: scope-8.epsx common.ps rect.ps ptr.ps break.ps dist.ps sv-8.ps
stack.png: stack.epsx common.ps rect.ps ptr.ps break.ps dist.ps sv.ps box.ps mws.ps
stack-8.png: stack-8.epsx common.ps rect.ps ptr.ps break.ps dist.ps sv-8.ps box.ps mws.ps
context.png: context.epsx common.ps rect.ps ptr.ps break.ps dist.ps sv.ps box.ps mws.ps
eval.png: eval.epsx common.ps rect.ps ptr.ps break.ps dist.ps sv.ps box.ps mws.ps
stash.png: stash.epsx common.ps stash.ps rect.ps ptr.ps box.ps glob.ps mws.ps sv.ps
strtab.png: strtab.epsx common.ps box.ps rect.ps mws.ps ptr.ps sv.ps
strtab-8.png: strtab.epsx common.ps box.ps rect.ps mws.ps ptr.ps sv-8.ps
sv_u.png: sv_u.epsx common.ps mws.ps rect.ps
svhead.png: svhead.epsx common.ps mws.ps rect.ps
svnull-8.png: svnull-8.epsx common.ps mws.ps rect.ps
#svhead-8.png: svhead-8.epsx common.ps mws.ps rect.ps
#svnull.png: svnull.epsx common.ps mws.ps rect.ps
sviv-8.png: sviv-8.epsx sv-8.ps common.ps rect.ps ptr.ps box.ps
sviv-10.png: sviv-10.epsx sv.ps common.ps rect.ps ptr.ps box.ps
sviv-14.png: sviv-14.epsx sv.ps common.ps rect.ps ptr.ps box.ps
svnv-8.png: svnv-8.epsx sv-8.ps common.ps rect.ps ptr.ps box.ps
svnv-10.png: svnv-10.epsx sv.ps common.ps rect.ps ptr.ps box.ps
svnv-14.png: svnv-14.epsx sv.ps common.ps rect.ps ptr.ps box.ps
svpv-8.png: svpv-8.epsx sv-8.ps common.ps rect.ps ptr.ps box.ps str.ps break.ps
svpv-10.png: svpv-10.epsx sv.ps common.ps rect.ps ptr.ps box.ps str.ps break.ps
svpv-14.png: svpv-14.epsx sv.ps common.ps rect.ps ptr.ps box.ps str-14.ps break.ps
svpvbm-8.png: svpvbm-8.epsx sv-8.ps common.ps rect.ps ptr.ps box.ps mws.ps magic.ps break.ps
svpvbm-10.png: svpvbm-10.epsx sv.ps common.ps rect.ps ptr.ps box.ps mws.ps magic-10.ps break.ps
svpvbm-14.png: svpvbm-14.epsx sv.ps common.ps rect.ps ptr.ps box.ps mws.ps magic-10.ps break.ps
svpvfm-8.png: svpvfm-8.epsx sv-8.ps common.ps rect.ps ptr.ps box.ps mws.ps break.ps
svpvfm-10.png: svpvfm-10.epsx sv.ps common.ps rect.ps ptr.ps box.ps mws.ps break.ps
svpvfm-14.png: svpvfm-14.epsx sv.ps common.ps rect.ps ptr.ps box.ps mws.ps break.ps
svpviv-8.png: svpviv-8.epsx sv-8.ps common.ps rect.ps ptr.ps box.ps str.ps break.ps
svpviv-10.png: svpviv-10.epsx sv.ps common.ps rect.ps ptr.ps box.ps str.ps break.ps
svpviv-14.png: svpviv-14.epsx sv.ps common.ps rect.ps ptr.ps box.ps str-14.ps break.ps
svpvlv-8.png: svpvlv-8.epsx sv-8.ps common.ps rect.ps ptr.ps box.ps mws.ps magic.ps
svpvlv-10.png: svpvlv-10.epsx sv.ps common.ps rect.ps ptr.ps box.ps mws.ps magic-10.ps
svpvlv-14.png: svpvlv-14.epsx sv.ps common.ps rect.ps ptr.ps box.ps mws.ps magic-10.ps
svpvmg-8.png: svpvmg-8.epsx sv-8.ps common.ps rect.ps ptr.ps box.ps mws.ps magic.ps chararray.ps
svpvmg-10.png: svpvmg-10.epsx sv.ps common.ps rect.ps ptr.ps box.ps mws.ps magic-10.ps chararray.ps
svpvmg-14.png: svpvmg-14.epsx sv.ps common.ps rect.ps ptr.ps box.ps mws.ps magic-10.ps chararray.ps
svpvnv-8.png: svpvnv-8.epsx sv-8.ps common.ps rect.ps ptr.ps box.ps str.ps break.ps
svpvnv-10.png: svpvnv-10.epsx sv.ps common.ps rect.ps ptr.ps box.ps str.ps break.ps
svpvnv-14.png: svpvnv-14.epsx sv.ps common.ps rect.ps ptr.ps box.ps str-14.ps break.ps
svrv-8.png: svrv-8.epsx sv-8.ps common.ps rect.ps ptr.ps box.ps
svrv.png: svrv.epsx sv.ps common.ps rect.ps ptr.ps box.ps
svtypes-8.png: svtypes-8.epsx common.ps arrow.ps
svtypes.png: svtypes.epsx common.ps arrow.ps
