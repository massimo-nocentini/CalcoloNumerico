## newtonMethod
##
## Questo oggetto matematico implementa il metodo di Newton.
## 
## Input:
##		f: nome della funzione di cui si vuole approssimare lo zero
##		f1: derivata della f
##		x0: punto di innesco del metodo
##		tolx: tolleranza assoluta accettata sull'approssimazione trovata
##		rtolx: tolleranza relativa accettata sull'approssimazione trovata
##
## Output: 	
##		x: approssimazione che rispetta la tolleranza richiesta
##		i: passi effettivamente eseguiti per ricavare l'approssimazione
##		ascisse: vettore di ascisse calcolate durante i passi del metodo

function [x, i, ascisse]=newtonMethod(f,f1,x0,itmax,tolx,rtolx)
i=0;
ascisse = [];
ascisse = [ascisse x0];

fx = invokeDelegate(f,x0); # applico la funzione

if fx==0
	x=x0;
	return
end

f1x = invokeDelegate(f1,x0); # applico la derivata
if f1x==0
	error('La derivata prima ha assunto valore zero impossibile continuare')
end

x= x0-(fx/f1x);
# la condizione del while utilizza una sottrazione, mal condizionata quando
# x e x0 sono vicini (ovvero quando il passo tende alla soluzione ricercata).
# provare a sostituire questo algoritmo usando invece il rapporto tra funzione
# e derivata. Non importa nessun controllo se la derivata e' null in quanto
# vengono eseguiti gia all'interno dell'algoritmo (righe 30 e 51)
# utilizzare il pattern strategy e passare un argomento al metodo per indicare
# quale strategia si desidera utilizzare.
while (i<itmax) & ((abs(x-x0)/(tolx+rtolx*(abs(x))))>1)
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
		elseif ((abs(x-x0)/(tolx+rtolx*(abs(x))))<=1)
			disp('f1(x) = 0 & stopCriterion reached');
			return
		end
		disp('La derivata prima ha assunto valore zero, impossibile continuare')
	end
	x = x0-fx/f1x;
end

# altrimenti l'ultima computazione di x (riga 54 ed eventualmente riga 34 nel caso
# in cui non ho nessuna iterazione del ciclo while) non vengono collezionate.
# Qui devo collezionare x e non x0, perche' x0 non viene aggiornato nell'ultima iterazione
ascisse = [ascisse x]; 

if ((abs(x-x0)/(tolx+rtolx*(abs(x))))>1)
	disp('Il metodo non converge.')
end

endfunction
