## newtonMethod
##
## Questo oggetto matematico implementa il metodo di Newton con molteplicita'
## dello zero nota.
## 
## Input:
##		f: nome della funzione di cui si vuole approssimare lo zero
##		f1: derivata della f
##		x0: punto di innesco del metodo
##		tolx: tolleranza assoluta accettata sull'approssimazione trovata
##		rtolx: tolleranza relativa accettata sull'approssimazione trovata
##		m: molteplicita' dello zero
##
## Output: 	
##		x: approssimazione che rispetta la tolleranza richiesta
##		i: passi effettivamente eseguiti per ricavare l'approssimazione
##		ascisse: vettore di ascisse calcolate durante i passi del metodo

function [x, i, ascisse]=newtonMethod(f,f1,x0,itmax,tolx,rtolx,m)

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

x1= x0-(m*fx/f1x);
ascisse = [ascisse x1]; # colleziono la prima iterata
fx1 = invokeDelegate(f,x1); # applico la funzione
if fx1==0
	x=x1;
	return
end
f1x1 = invokeDelegate(f1,x1); # applico la derivata
if f1x1==0
	error('La derivata prima ha assunto valore zero nella prima iterata, impossibile continuare')
end

x= x1-(m*fx1/f1x1); # non colleziono qui in ascisse perche' viene fatto subito dopo il while se non ci sono iterazioni.

# while initialization
x0 = x1; # mi riporto nella condizione per poter far lavorare correttamente la condizione del while
i=2; # ho gia calcolato due passi x1 ed x
c = abs(x - x1) / abs(x1 - x0);
while (i<itmax) & ((abs(x-x0) / abs(tolx*((1-c)/c)))>1)
	i = i+1;
	x0 = x;
	ascisse = [ascisse x0]; # colleziono la nuova ascissa
	
	fx = invokeDelegate(f,x0);
	f1x = invokeDelegate(f1,x0);
	
	%Se la derivata vale zero non possiamo continuare:
	% controllo che non si abbia raggiunto una soluzione
	% rispettando le tolleranze richieste.
	if f1x==0
		if fx == 0
			disp('f(x) = f1(x) = 0');
			return
		elseif ((abs(x-x0) / abs(tolx*((1-c)/c)))<=1)
			disp('f1(x) = 0 & stopCriterion reached');
			return
		end
		disp('La derivata prima ha assunto valore zero, impossibile continuare')
	end
	x = x0-(m*fx/f1x);
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
