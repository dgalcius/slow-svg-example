default: report.htm

test-alt: report.htm-x

%.htm: %.tex
	make4ht --lua -u -c ./nma.cfg  -e ./main.mk4 $< "htm,3,pic-align,notoc*" | tee runtime.log.txt


clean:
	rm -f *.aux *.log *.4ct *.4tc *.tmp *.xref *.cpt

distclean: clean
	rm -f report.dvi *.lg *.idv *.htm *.css *.svg


report.htm-x : export TEXINPUTS=.;./source;
report.htm-x:
	./htdvilualatex
	tex4ht  -cmozhtf -utf8 "report.dvi"
# option -p ===> -- do not convert pictures
	t4ht -p "report.dvi"
	pages=`ruby lg.rb report.lg`; \
	echo pages: $$pages > pages.txt;  \
	dviselect $$pages report.idv images.dvi ; \
	dvisvgm --no-fonts --exact --scale=1.1,1.1 --page=1- --output="re%1(p-1)x" images.dvi
	rm -f images.dvi

#svg: images.dvi
	pages=`cat pages.txt`; \
#	dvisvgm --no-fonts --exact --scale=1.1,1.1 --page=1- --output="re%1(p-1)x" images.dvi 2> /dev/null
#	dvisvgm --no-fonts --scale=1.1,1.1 --page=1- --output="re%1(p-1)x" images.dvi 
