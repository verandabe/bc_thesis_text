THESIS=thesis
BIB=bibliography.bib
PDFLATEX=pdflatex --shell-escape
AUXFILES=*.aux *.log *.out *.toc *.lot *.lof *.bcf *.blg *.run.xml \
         *.bbl *.idx *.ind *.ilg *.markdown.* *.acn *.acr *.alg *.glg *.glo \
         *.gls *.glsdefs *.ist
PARTS=$(wildcard *.tex)
DATA=$(wildcard data/*)

.PHONY: all clean wipe

all: $(THESIS).pdf

$(THESIS).pdf: $(THESIS).tex $(BIB) $(PARTS) $(GRAPHS) $(DATA)
	$(PDFLATEX) -interaction=batchmode $< # The initial typesetting.
	biber $(basename $<).bcf
	makeglossaries $(THESIS)
	$(PDFLATEX) -interaction=batchmode $< # Update the index after the bibliography insertion.
	texfot $(PDFLATEX) $< # The final typesetting, now also with index.

clean:
	rm -f $(AUXFILES)

wipe: clean
	rm -f $(THESIS).pdf
