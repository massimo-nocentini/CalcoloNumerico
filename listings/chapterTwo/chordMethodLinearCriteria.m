## chordMethodLinearCriteria
##
## Questo oggetto matematico implementa il metodo delle corde. 
## Questa implementazione utilizza il criterio di arresto lineare di
## pag. 36.
## 
## Input:
##		f: nome della funzione di cui si vuole approssimare lo zero
##		f1: derivata della f
##		x0: punto di innesco del metodo
##		itmax: numero massimo di iterazioni per fermare la computazione nel caso il metodo non converge.
##		tolx: tolleranza assoluta accettata sull'approssimazione trovata
##		rtolx: tolleranza relativa accettata sull'approssimazione trovata
##
## Output: 	
##		x: approssimazione che rispetta la tolleranza richiesta
##		i: passi effettivamente eseguiti per ricavare l'approssimazione
##		ascisse: vettore di ascisse calcolate durante i passi del metodo

function [x, i, ascisse]=chordMethodLinearCriteria(f,f1,x0,itmax,tolx,rtolx)

ascisse = [];
ascisse = [ascisse x0]; # colleziono il punto di innesco

fx = invokeDelegate(f,x0); # applico la funzione
if fx==0
	x=x0;
	return
end
f1x = invokeDelegate(f1,x0); # applico la derivata
if f1x==0
	error('La derivata prima ha assunto valore zero nel punto di innesco, impossibile continuare')
end

x1= x0-(fx/f1x);
ascisse = [ascisse x1]; # colleziono la prima iterata
fx1 = invokeDelegate(f,x1); # applico la funzione
if fx1==0
	x=x1;
	return
end

x= x1-(fx1/f1x); # non colleziono qui in ascisse perche' viene fatto subito dopo il while se non ci sono iterazioni.

c = abs(x - x1) / abs(x1 - x0);

# while initialization
i=2; # ho gia calcolato due passi x1 ed x
# non importa resettare le due variabili x0 ed x1 in quanto vengono settate (solo x0)
# all'interno del ciclo
while (i<itmax) & ((abs(x-x0) / abs(tolx*((1-c)/c)))>1)
	i = i+1;
	x0 = x;
	ascisse = [ascisse x0]; # colleziono la nuova ascissa
	
	fx = invokeDelegate(f,x0);
	
	% qui non ha senso controllare se la derivata si annulla in quanto questo
	% controllo viene fatto alla riga 30.
	
	x = x0-(fx/f1x);
	
	# posso considerare ascisse(length(ascisse)) = x(i-1) perche' ancora non ho collezionato x
	c = abs(x - ascisse(length(ascisse))) / abs(ascisse(length(ascisse)) - ascisse(length(ascisse) - 1));
end

# altrimenti l'ultima computazione di x (riga 54 ed eventualmente riga 34 nel caso
# in cui non ho nessuna iterazione del ciclo while) non vengono collezionate.
# Qui devo collezionare x e non x0, perche' x0 non viene aggiornato nell'ultima iterazione
ascisse = [ascisse x]; 
c = abs(ascisse(length(ascisse)) - ascisse(length(ascisse) - 1)) / abs(ascisse(length(ascisse) - 1) - ascisse(length(ascisse) - 2));

if ((abs(x-x0) / abs(tolx*((1-c)/c)))>1)
	disp('Il metodo non converge.')
end

endfunction
