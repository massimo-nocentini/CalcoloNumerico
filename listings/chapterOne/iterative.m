## This program capture an iterative method that converges to sqrt(2).
## It take two initial step to start the creation of the approximation 
## succession's values.
## It display at each step the value of the created succession value and 
## show the difference with the previous one.
## The least operation that is done is to show the distance from the 
## Octave value of sqrt(2).
## The parameters order's is important: the first is the first step, 
## the second is the second step, be careful before swap their position!

function iterative (val1, val2)
	format long e
	next = val2;	
	while (abs(sqrt(2) - next) > 1e-12)
		next = ((val1 * val2) + 2) / (val1 + val2)	
		disp (strcat("Difference with last step: ", num2str(abs(val2 - next), 15)))		

		val1 = val2;
		val2 = next;
	end

	disp (strcat("Difference with sqrt(2): ", num2str(abs(sqrt(2) - next), 15)))

	format
endfunction
