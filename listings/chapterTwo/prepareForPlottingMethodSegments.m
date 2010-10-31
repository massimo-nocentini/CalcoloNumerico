## prepareForPlottingMethodSegments
## questa funzione ha il compito di restituire due nuovi vettori
## per effettuare la stampa dei segmenti che congiungono gli zeri
## calcolati dal metodo con la successiva valutazione.
## Duplicano ogni elemento del vettore delle ascisse in quanto
## per ogni x, avro' uno zero (che viene calcolato dal metodo)
## ed una valutazione di funzione, quindi per poter usare
## in modo trasparente la funzione di Octave plot, devo
## restituire questi due punti identici ma doppioni
## per poi congiungere con una spezzata da una coordinata zero
## (per riferirmi sempre all'asse delle ascisse) ed una coordinata
## la valutazione della funzione.

function [ preparedXs, preparedYs ] = prepareForPlottingMethodSegments(ascisse, f_name)
preparedXs = [];
preparedYs = [];
for i = 1:length(ascisse)
	preparedXs = [preparedXs ascisse(i)];
	preparedXs = [preparedXs ascisse(i)];
	
	preparedYs = [preparedYs 0];
	preparedYs = [preparedYs feval(f_name, ascisse(i))];
end
endfunction
