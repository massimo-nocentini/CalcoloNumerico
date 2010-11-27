## PALUmethod

function [L, U, p, unknowns] = PALUmethod (A, b)
[L, U, p] = factorPALU(A);

n = length(b);
clone = b;
for i = 1:n
	b(i) = clone(p(i));
end

unknowns = triangularSystemSolver(U, triangularSystemSolver(L, b, "lowerSolveEngine"), "upperSolveEngine");
endfunction

function [L, U, p] = factorPALU (A)
n = length(A);
p = [1:n];
for i = 1:n-1
	[mi, ki] = max(abs(A(i:n, i)));
	
	if mi == 0
		error("A singolare.");
	end

	ki = ki + i -1;
	if ki > i
		A([i ki], :) = A([ki i], :);
		p([i ki]) = p([ki i]);
	end
	
	A(i+1:n,i) = A(i+1:n,i)/A(i,i);
	A(i+1:n,i+1:n) = A(i+1:n, i+1:n) - A(i+1:n,i) * A(i, i+1:n);	
end
L = normalizationEngine("normalizeLowerTriangular", A, 1);
U = normalizationEngine("normalizeUpperTriangular", A, 0);
endfunction
