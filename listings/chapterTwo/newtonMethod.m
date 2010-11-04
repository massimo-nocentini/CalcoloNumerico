## newtonMethod
##
## Questo oggetto matematico implementa il metodo di Newton.
## 
## Input:
##		f: nome della funzione di cui si vuole approssimare lo zero
##		f1: derivata della f
##		x0: punto di innesco del metodo
##		itmax: numero massimo di iterazioni per fermare la computazione nel caso il metodo non converge.
##		tolx: tolleranza assoluta accettata sull'approssimazione trovata
##		rtolx: tolleranza relativa accettata sull'approssimazione trovata
##		stopCriterion: nome del criterio che si vuole utilizzare criterio di arresto.
##
## Output: 	
##		x: approssimazione che rispetta la tolleranza richiesta
##		i: passi effettivamente eseguiti per ricavare l'approssimazione
##		ascisse: vettore di ascisse calcolate durante i passi del metodo
##		checkedTolXs: vettore di tolleranze che sono state controllate nel criterio di arresto.

function [x, i, ascisse, checkedTolXs]=newtonMethod(f,f1,x0,itmax,tolx,rtolx,stopCriterion)
i=0;
ascisse = [];
ascisse = [ascisse x0];
checkedTolXs = []; # array delle tolleranze controllate

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
tolXToCheck = feval(stopCriterion, x, x0, fx, f1x);
 
while (i<itmax) & (tolXToCheck/(rtolx*abs(x) + tolx)>1)
	checkedTolXs = [checkedTolXs tolXToCheck];
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
		elseif (feval(stopCriterion, x, x0, fx, f1x)/(rtolx*abs(x) + tolx)<=1)
			disp('f1(x) = 0 & stopCriterion reached');
			return
		end
		disp('La derivata prima ha assunto valore zero, impossibile continuare')
	end
	x = x0-fx/f1x;
	tolXToCheck = feval(stopCriterion, x, x0, fx, f1x);
end

# colleziono l'ultima tolX che non e' stata aggiunta nel ciclo while
checkedTolXs = [checkedTolXs tolXToCheck]; 

# altrimenti l'ultima computazione di x (riga 63 ed eventualmente riga 38 nel caso
# in cui non ho nessuna iterazione del ciclo while) non vengono collezionate.
# Qui devo collezionare x e non x0, perche' x0 non viene aggiornato nell'ultima iterazione
ascisse = [ascisse x]; 

if (tolXToCheck/(rtolx*abs(x) + tolx)>1)
	disp('Il metodo non converge.')
end

endfunction

function result = incrementCriterion (x, x0, fx0, f1x0)
	result = abs(x-x0);
endfunction

function result = residueCriterion (x, x0, fx0, f1x0) 
	result = fx0/f1x0;
endfunction
