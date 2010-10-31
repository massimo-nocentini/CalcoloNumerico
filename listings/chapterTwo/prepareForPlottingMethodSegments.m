## prepareForPlottingMethodSegments
## questa funzione ha il compito di restituire due nuovi vettori
## per effettuare la stampa dei segmenti che congiungono gli zeri
## calcolati dal metodo con la successiva valutazione.
## Duplicano ogni elemento del vettore delle ascisse in quanto
## per ogni x, avro' uno zero approssimato (che viene calcolato dal metodo)
## ed una valutazione di funzione in quel punto; per poter usare
## in modo trasparente la funzione di Octave plot, devo
## restituire questi due punti identici ma doppioni
## per poi congiungere con una spezzata da una ordinata zero
## (per riferirmi sempre all'asse delle ascisse) ed una coordinata uguale
## alla valutazione della funzione.
##
## Input:
##		- ascisse: vettore di ascisse che si vuole preparare per rappresentare  
##			il comportamento del metodo (la curva rossa descritta nell'elaborato)
##		- f_name: nome della funzione che si vuole applicare ad ogni punto
##			contenuto nell'array ascisse. Se f_name rappresenta un nome di funzione
## 			diverso da "invokeDelegate", ovvero rappresenta in modo esplicito una funzione,
##			allora passare il parametro "f_argument" = "" 
##
##			Devo prestare attenzione se la funzione
##			da valutare e' "invokeDelegate", in quanto essendo per costruzione una 
##			funzione, posso chiedere di usarla per prepare vettori per un grafico.
##			In questo caso, deve passare anche il nome della funzione che il delegato
##			dovra' invocare, introducendo il parametro f_argument.
##		- f_argument, rappresenta il nome della funzione che l'oggetto "invokeDelegate"
##			dovra' invocare, quindi sara' valorizzato solo nel caso si utilizzi
##			un delegato, quindi una rappresentazione implicita della funzione che si vuole
##			utilizzare.

function [ preparedXs, preparedYs ] = prepareForPlottingMethodSegments(ascisse, f_name, f_argument)
preparedXs = [];
preparedYs = [];
for i = 1:length(ascisse)
	# duplico l'oggetto ascisse(i) in modo da avere il punto (ascisse(i), 0) e 
	# il punto (ascisse(i), feval(f_name, ascisse(i)) per poter disegnare una spezzata
	# con la funzione plot.
	preparedXs = [preparedXs ascisse(i)];
	preparedXs = [preparedXs ascisse(i)];

	# associo al primo dei due oggetti duplicati ascisse(i) il valore 0 (come descritto
	# nel commento precedente) 
	preparedYs = [preparedYs 0];
	
	if strcmp(f_name, "invokeDelegate") == 1
		# se sto usando un delegato allora invoco il delgato, passando il nome
		# della funzione che il delegato (f_name == "invokeDelegate") deve invocare (f_argument)
		# con argomento ascisse(i) su cui "f_argument" verra' applicata.
		# Ho un doppio livello di indirezione: feval > invokeDelegate
		preparedYs = [preparedYs feval(f_name, f_argument, ascisse(i))];
	else
		# f_name rappresenta in modo diretto una funzione, quindi posso utilizzare
		# la feval nel modo classico, invocando f_name con argomento ascisse(i)
		preparedYs = [preparedYs feval(f_name, ascisse(i))];
	end
end
endfunction
