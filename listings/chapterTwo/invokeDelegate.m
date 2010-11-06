## invokeDelegate
## 
## Questo oggetto matematico incapsula tutte le funzioni che verranno utilizzate
## nelle applicazioni descritte nell'elaborato per quanto riguardo i metodi
## iterativi.
## Per definizione della gestione delle funzioni di Octave e' possibile invocare
## solo la prima funzione di questo file, quindi i client di questo oggetto
## matematico riescono ad usufruire solo della funzione "invokeDelegate".
## Per evitare di costruire un file per ogni funzione che viene usata dalle 
## applicazioni, ho costruito questo oggetto come un "invocatore" di funzioni mono-
## parametro, in modo da inserire in questo file tutte le funzioni di cui ho 
## bisogno nelle applicazioni dei vari metodi. Questo oggetto rappresenta un 
## entry-point per le funzioni successive alla sua dichiarazione, le quali vengono
## nascoste da invokeDelegate.
##
## Input: 
## 	- function_name: nome della funzione che si vuole invocare, in formato stringa
##		deve essere una tra quelle elencate dopo la funzione "invokeDelegate".
##		Ognuna di queste funzioni deve avere un solo parametro
##	- argument: argomento a cui applicare la funzione "function_name", puo'
## 		essere di qualsiasi tipo, basta che la relativa funzione riesca a lavorarlo
## Output:
## 	- ret: array di oggetti, ognuno dei quali e' l'applicazione della funzione
##		"function_name" all'i-esimo elemento dell'array "argument" passato
##		come parametro.

function [ ret ] = invokeDelegate (function_name, argument)
	ret = [];
	# ho implementato questo ciclo perche la feval non era trasparente come
	# una funzione scalare, ovvero non funzionava quando 'argument' viene passato
	# come array.
	# questo ciclo mi serve quando uso comandi come questo
	# plot(xSingleZero, ySingleZero, "c", ascisse, invokeDelegate('singleZero', ascisse), "b+", prepX, prepY, "r")
	# che utilizzano direttamente questo oggetto passando un vettore di argomenti (ascisse nell'esempio)
	for i = 1:length(argument)
		value = feval(function_name, argument(i));
		ret = [ret value]; # colleziono ogni valore computato
	end
endfunction

function [ ret ] = singleZero (x)
	ret = (x - 3)*(x + 4) - 3;
endfunction

function [ ret ] = singleZeroDerivative (x)
	ret = (x + 4) + (x - 3);
endfunction

function [ ret ] = functionWithNoRealZero (x)
	ret = x^(2) + x + 1;
endfunction

function [ ret ] = functionWithNoRealZeroDerivative (x)
	ret = 2*x + 1;
endfunction

function [ ret ] = functionNewtonRecursion (x)
	ret = x^(3) - 5 * x;
endfunction

function [ ret ] = functionNewtonRecursionDerivative (x)
	ret = 3 * x^(2) - 5;
endfunction

# funzione relativa all'esercizio 2.5
function [ ret ] = function25first (x)
	ret = (x - 1)^(10);
endfunction

function [ ret ] = function25firstDerivative (x)
	ret = 10 * (x - 1)^(9);
endfunction

# funzione relativa all'esercizio 2.5
function [ ret ] = function25second (x)
	ret = (x - 1)^(10) * exp(x);
endfunction

# funzione relativa all'esercizio 2.5
function [ ret ] = function25secondDerivative (x)
	ret = exp(x) * (10 * (x - 1)^(9) + (x - 1)^(10));
endfunction

function [ ret ] = chordConvergenceFunction (x)
	ret = (x - 3)^(3) + x;
endfunction

function [ ret ] = chordConvergenceFunctionDerivative (x)
	ret = 3 * (x - 3)^(2) + 1;
endfunction

function [ ret ] = secantConvergenceFunction (x)
	ret = x^(2) - x;
endfunction

function [ ret ] = secantConvergenceFunctionDerivative (x)
	ret = 2 * x - 1;
endfunction
