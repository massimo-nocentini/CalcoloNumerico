function [ ascisse, interpolatedYs, realYs ] = exercise41 (ascisse)
xVector = [0 1 2 3 4]'; #costruisco vettore colonna delle ascisse da interpolare
ordinates = computesOrdinates(xVector);

# the following two statement are need to initialize the 
# vectors realYs and interpolatedYs
interpolatedYs = ascisse;
realYs = ascisse;

# perform the computation and find the interpolated value and
# the effective value.
for i=1:length(ascisse)
	interpolatedYs(i) = interpolationPoly(ascisse(i), ordinates);
	realYs(i) = contextFunction(ascisse(i));
end

endfunction

function [ ordinates ] = computesOrdinates(xVector)
    ordinates = xVector;
    for i=1:5
	    ordinates(i) = contextFunction(xVector(i));
    end
endfunction

function [result] = contextFunction(x)
	result = 4*x^(2) -(12*x) +1;
endfunction

function [result] = interpolationPoly(x, ordinates)
	result = ordinates(1)*baseVector04(x) + ...
		ordinates(2)*baseVector14(x) + ...
		ordinates(3)*baseVector24(x) + ...
		ordinates(4)*baseVector34(x) + ...
		ordinates(5)*baseVector44(x);
endfunction

# costruzione della base di Lagrange
function [result] = baseVector04(x)
	result = ((x-1)*(x-2)*(x-3)*(x-4))/((0-1)*(0-2)*(0-3)*(0-4));
endfunction

function [result] = baseVector14(x)
	result = ((x-0)*(x-2)*(x-3)*(x-4))/((1-0)*(1-2)*(1-3)*(1-4));
endfunction

function [result] = baseVector24(x)
	result = ((x-0)*(x-1)*(x-3)*(x-4))/((2-0)*(2-1)*(2-3)*(2-4));
endfunction

function [result] = baseVector34(x)
	result = ((x-0)*(x-1)*(x-2)*(x-4))/((3-0)*(3-1)*(3-2)*(3-4));
endfunction

function [result] = baseVector44(x)
	result = ((x-0)*(x-1)*(x-2)*(x-3))/((4-0)*(4-1)*(4-2)*(4-3));
endfunction
