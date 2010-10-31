## newton

function [x,i]=newton(f,f1,x0,itmax,tolx,rtolx)
i=0;
fx = feval(f,x0);

if fx==0
	x=x0;
	return
end
f1x = feval(f1,x0);
if f1x==0
error(’La derivata prima ha assunto valore zero, impossibile continuare!’)
end
x= x0-fx/f1x;
while (i<itmax) & ((abs(x-x0)/(tolx+rtolx*(abs(x))))>1)
i = i+1;
x0 = x;
fx = feval(f,x0);
f1x = feval(f1,x0);
%Se la derivata vale zero non possiamo continuare, rimane solo da
% controllare che non si abbia raggiunto ugualmente una soluzione
% nelle condizioni di tolleranza richieste.
if f1x==0
if fx == 0
return
elseif ((abs(x-x0)/(tolx+rtolx*(abs(x))))<=1)
return
end
error(’La derivata prima ha assunto valore zero, impossibile continuare!’)
28
CAPITOLO 2. RADICI DI UNA EQUAZIONE
end
x = x0-fx/f1x;
end
%Se il ciclo sopra e’ terminato perche’ abbiamo raggiunto il limite massimo di
%iterazioni, non abbiamo ottenuto un risultato accettabile.
if ((abs(x-x0)/(tolx+rtolx*(abs(x))))>1), disp(’Il metodo non converge.’), end

endfunction
