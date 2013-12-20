TEX=platex
DVIPDF=dvipdfmx
DVIPDFFLAGS=-pa4
DVIPS=dvips

PREFIX=ihou
DVI=${PREFIX}.dvi
PDF=${PREFIX}.pdf
PS=${PREFIX}.ps
BOOK=${PREFIX}-print.pdf
TEXFILES=ihou.tex iq.tex editor.tex colophon.tex cover.tex
PSFILES=am.ps carr.ps sig.ps i.ps q.ps demodulate.ps out.ps

.suffix: .tex .dvi

all: ${DVI}

pdf: ${PDF}

ps: ${PS}

book: ${BOOK}


${DVI}: ${TEXFILES} ${PSFILES}
	${TEX} ihou.tex
	${TEX} ihou.tex

${PDF}: ${DVI} 
	${DVIPDF} ${DVI}

${PS}: ${DVI} 
	${DVIPS} ${DVI}

${BOOK}: ${PS}
	psbook ${PS} | psnup -2 |  ps2pdf - ${BOOK}
#	psbook ${PS} | psnup -2 | psresize -p A3 | ps2ps -sPAPERSIZE=a3 - - | ps2pdf - ${BOOK}


clean:
	rm -f ${DVI} ${PDF} ${PS} ${BOOK} *.log *.aux

