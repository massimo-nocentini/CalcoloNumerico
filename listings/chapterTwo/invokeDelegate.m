## invokeDelegate

function [ ret ] = invokeDelegate (function_name, argument)
	ret = [];
	# ho implementato questo ciclo perche la feval non era trasparente come
	# una funzione scalare, ovvero non funzionava quando 'argument' viene passato
	# come array.
	for i = 1:length(argument)
		value = feval(function_name, argument(i));
		ret = [ret value];
	end
endfunction

function [ ret ] = singleZero (x)
	ret = (x - 3)*(x + 4) - 3;
endfunction

function [ ret ] = singleZeroDerivative (x)
	ret = (x + 4) + (x - 3);
endfunction