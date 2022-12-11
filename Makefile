all: ziffers.pdf ziffers.html

clean:
	rm ziffers.pdf ziffers.html

ziffers.html: ziffers.md references.bib
	pandoc --template=pandoc/iclc.html --citeproc --number-sections ziffers.md -o ziffers.html --pdf-engine=xelatex


ziffers.pdf: ziffers.md references.bib pandoc/iclc.latex pandoc/iclc.sty
	pandoc --template=pandoc/iclc.latex --citeproc --number-sections ziffers.md -o ziffers.pdf --pdf-engine=xelatex 


ziffers.docx: ziffers.md references.bib
	pandoc --citeproc --number-sections ziffers.md -o ziffers.docx