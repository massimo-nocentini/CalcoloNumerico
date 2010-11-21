## LUmethod

function [L, U, unknowns] = LUmethod (A, b)
[L, U] = factorLU(A);
unknowns = triangularSystemSolver(U, triangularSystemSolver(L, b, "lowerSolveEngine"), "upperSolveEngine");
endfunction

function [L, U] = factorLU (A)
n = length(A);
for i = 1:n-1
	if A(i,i) == 0
		error('A non fattorizzabile LU');
	end
	
	A(i+1:n,i) = A(i+1:n,i)/A(i,i);
	A(i+1:n,i+1:n) = A(i+1:n, i+1:n) - A(i+1:n,i) * A(i, i+1:n);	
end
L = normalizationEngine("normalizeLowerTriangular", A, 1);
U = normalizationEngine("normalizeUpperTriangular", A, 0);
endfunction