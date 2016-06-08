TEX = pdflatex
main = caratula

.PHONY = all clean

all: $(main).tex
	$(TEX) $(main).tex
	
clean:
	rm -f $(main).aux
	rm -f $(main).log
	rm -f $(main).toc
	rm -f $(main).out
	rm -f $(main).synctex.gz
	rm -f $(main).pdf
