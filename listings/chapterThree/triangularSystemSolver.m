## triangularSystemSolver

function [ ret ] = triangularSystemSolver (A, b, typeOfMatrix)
ret = feval(typeOfMatrix, A, b);
end
endfunction

function [ unknowns ] = lowerSolveEngine(A, b)
	unknowns = b;
	n = length(unknowns);
	for j = 1:n
		unknowns(j) = unknowns(j) / A(j,j);
		for i = j+1:n
			unknowns(i) = unknowns(i) - A(i,j) * unknowns(j);
		end
	end
endfunction

function [ unknowns ] = upperSolveEngine(A, b)
	unknowns = b;
	n = length(unknowns);
	for j = n:-1:1
		unknowns(j) = unknowns(j) / A(j,j);
		for i = 1:j-1
			unknowns(i) = unknowns(i) - A(i,j) * unknowns(j);
		end
	end
endfunction