## errorMonitor
## Questo oggetto matematico costruisce un vettore di fattori di amplificazione
## k, relativamente al vettore di valori passati come ingresso. 
##
## I fattori di amplificazione sono calcolati tra valori adiacenti, per questo
## motivo vale questa legge length(array) = length(error) + 1.

function [ errors ] = errorMonitor (array)
errors = [];
for i = 1:length(array) - 1
	error = (abs(array(i)) + abs(array(i+1)))/abs(array(i) - array(i+1));
	errors = [errors error];
end
endfunction
