Questo file contiene tutti quegli appunti di natura legata allo sviluppo
di questo documento che non interessano gli argomenti contenuti ma solo la loro
strutturazione e appunti su come eseguire determinati task.

Per quanto riguarda il replay dei metodi iterativi descritti in questo contesto,
basta rieseguire con Octave i comandi inseriti nei codici sorgenti inseriti
all'interno di environment "lstlisting". Ad esempio, riprendendo dal file di 
bisection.tex:
\begin{lstlisting}
octave:45> [x, i, imax, ascisse] = bisectionMethod('sin', 2, 5, e^-14)
x =  3.14159250259399e+00
i =  2.10000000000000e+01
imax =  2.20000000000000e+01
ascisse =
 Columns 1 through 3:
   3.50000000000000e+00   2.75000000000000e+00   3.12500000000000e+00
 Columns 4 through 6:
   3.31250000000000e+00   3.21875000000000e+00   3.17187500000000e+00
 Columns 7 through 9:
   3.14843750000000e+00   3.13671875000000e+00   3.14257812500000e+00
 Columns 10 through 12:
   3.13964843750000e+00   3.14111328125000e+00   3.14184570312500e+00
 Columns 13 through 15:
   3.14147949218750e+00   3.14166259765625e+00   3.14157104492188e+00
 Columns 16 through 18:
   3.14161682128906e+00   3.14159393310547e+00   3.14158248901367e+00
 Columns 19 through 21:
   3.14158821105957e+00   3.14159107208252e+00   3.14159250259399e+00
octave:46> xsin = min(ascisse):0.01:max(ascisse)
octave:47> ysin = feval('sin', xsin)
octave:48> [prepX, prepY] = prepareForPlottingMethodSegments(ascisse, 'sin')
octave:49> plot(xsin, ysin, "c", ascisse, feval('sin', ascisse), "b+", prepX, prepY, "r")
octave:50> print 'bisectionPlotOutput.tex' '-dTex' '-S800, 600'
\end{lstlisting}

per rieseguire questo metodo e' sufficiente rieseguire ogni istruzione
di ogni "octave:x>", in questo modo posso sempre rieseguire il metodo.

OSSERVAZIONE: e' importante riportare qualsiasi modifica fatta al sorgente
altrimenti si riproduce un metodo zoppo! 

-------------------------------------------------------------------------------

Per avviare Octave permettendo di poter lavorare correttamente con le invocazioni
dei delegati e' necessario portarsi nella cartella degli script desiderata
(i.e. Elaborato/listings/chapterTwo/) ed avviare Octave, adesso abbiamo a disposizione
tutte le funzioni necessarie per poter rieseguire gli esempi del testo. 

-------------------------------------------------------------------------------

