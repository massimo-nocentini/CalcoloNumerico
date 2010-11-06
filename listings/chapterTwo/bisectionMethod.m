## bisectionMethod
##
## Questo oggetto matematico implementa il metodo di bisezione.
## 
## Input:
##		f: nome della funzione di cui si vuole approssimare lo zero
##		a: estremo inferiore dell'intervallo di confidenza
##		b: estremo superiore dell'intervallo di confidenza
##		tolx: tolleranza accettata sull'approssimazione trovata
##
## Output: 	
##		x: approssimazione che rispetta la tolleranza richiesta
##		i: passi effettivamente eseguiti per ricavare l'approssimazione
##		imax: numero massimo di passi necessari per ricavare l'approssimazione
##		ascisse: vettore di ascisse calcolate durante i passi del metodo

function [ x,i,imax,ascisse ] = bisectionMethod (f,a,b,tolx)
ascisse = [];
fa = invokeDelegate(f,a);
fb = invokeDelegate(f,b);

x=(a+b)/2;
ascisse = [ascisse x];

fx = invokeDelegate(f,x);
imax = ceil(log2(b-a)-log2(tolx));
for i = 2:imax
	f1x = ((fb-fa)/(b-a));
	if abs(fx)<=tolx*abs(f1x);
		break
	elseif fa*fx<0
		b=x;
		fb=fx;
	else
		a=x;
		fa=fx;
	end
	x=(a+b)/2;
	ascisse = [ascisse x];
	fx=invokeDelegate(f,x);
end
i = i - 1;
endfunction
