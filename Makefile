ps: symbolicLinksChecker
	# compile two times in order to have all correct references setted
	latex Elaborato.tex && dvips -t a4 -Ppdf Elaborato.dvi
	#latex Elaborato.tex && dvips -t a4 -Ppdf Elaborato.dvi

pdf: ps
	ps2pdf Elaborato.ps Elaborato.pdf

symbolicLinksChecker: 
	# enable the script to be an executive file
	chmod +x fileExistsScript.sh
	# run the checking script
	./fileExistsScript.sh 
