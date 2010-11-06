## prepareForPlottingSecantMethodSegments
## questa funzione ha il compito di restituire due nuovi vettori
## per effettuare la stampa dei segmenti che congiungono gli zeri
## calcolati dal metodo delle secanti con la successiva valutazione.
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

function [ preparedXs, preparedYs ] = prepareForPlottingSecantMethodSegments (ascisse, f_name, f_argument)
preparedXs = [];
preparedYs = [];

for i = 1:length(ascisse)
	
	# region: add the point with coordinate (ascisse(i), f(ascisse(i)) --------
	# graphically i go to the evaluation point
	preparedXs = [preparedXs ascisse(i)];

	if strcmp(f_name, "invokeDelegate") == 1
		# se sto usando un delegato allora invoco il delgato, passando il nome
		# della funzione che il delegato (f_name == "invokeDelegate") deve invocare (f_argument)
		# con argomento ascisse(i) su cui "f_argument" verra' applicata.
		# Ho un doppio livello di indirezione: feval > invokeDelegate
		y = feval(f_name, f_argument, ascisse(i));
	else
		# f_name rappresenta in modo diretto una funzione, quindi posso utilizzare
		# la feval nel modo classico, invocando f_name con argomento ascisse(i)
		y = feval(f_name, ascisse(i));
	end
	preparedYs = [preparedYs y];
	# endregion ---------------------------------------------------------------

	# region: add the point with coordinate (ascisse(i), 0) -------------------
	# graphically I go down the the ascissa line
	preparedXs = [preparedXs ascisse(i)];
	preparedYs = [preparedYs 0];
	# endregion ---------------------------------------------------------------
	
	# region: add the point with coordinate (ascisse(i), f(ascisse(i)) ---------
	# graphically I come back up to the evaluation point.
	preparedXs = [preparedXs ascisse(i)];
	preparedYs = [preparedYs y];
	# endregion ---------------------------------------------------------------
		
	# region: add the point with coordinate (ascisse(i+2), 0) -----------------
	# graphically I go to the +2 element down to the ascissa line to "draw" the secante line
	if (length(ascisse) >= i + 2)
		preparedXs = [preparedXs ascisse(i + 2)];
		preparedYs = [preparedYs 0];
	end
	# endregion ---------------------------------------------------------------
end
endfunction