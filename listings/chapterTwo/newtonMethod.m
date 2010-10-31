## newtonMethod

function [x, i, ascisse]=newtonMethod(f,f1,x0,itmax,tolx,rtolx)
i=0;
ascisse = [];
ascisse = [ascisse x0];

fx = invokeDelegate(f,x0);

if fx==0
	x=x0;
	return
end

f1x = invokeDelegate(f1,x0);
if f1x==0
	x0
	error('La derivata prima ha assunto valore zero impossibile continuare')
end

x= x0-(fx/f1x);
while (i<itmax) & ((abs(x-x0)/(tolx+rtolx*(abs(x))))>1)
	i = i+1;
	x0 = x;
	ascisse = [ascisse x0];
	
	fx = invokeDelegate(f,x0);
	f1x = invokeDelegate(f1,x0);
	
	%Se la derivata vale zero non possiamo continuare, rimane solo da
	% controllare che non si abbia raggiunto ugualmente una soluzione
	% nelle condizioni di tolleranza richieste.
	if f1x==0
		if fx == 0
			return
		elseif ((abs(x-x0)/(tolx+rtolx*(abs(x))))<=1)
			return
		end
		error('La derivata prima ha assunto valore zero, impossibile continuare')
	end
	x = x0-fx/f1x;
end

# altrimenti l'ultima computazione di x (riga 40 ed eventualmente 20 nel caso
# in cui non ho nessuna iterazione del ciclo while) non la considero.
ascisse = [ascisse x]; 

if ((abs(x-x0)/(tolx+rtolx*(abs(x))))>1)
	disp('Il metodo non converge.')
end

endfunction
