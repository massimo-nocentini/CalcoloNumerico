## LDLmethod

function [L, D, unknowns] = LDLmethod (A, b)
[L, D] = factorLDL(A);
unknowns = triangularSystemSolver(L', triangularSystemSolver(L, triangularSystemSolver(D, b, "lowerSolveEngine"), "lowerSolveEngine"), "upperSolveEngine");
endfunction

function [ L, D ] = factorLDL (A)
n = length(A);

if A(1,1) <= 0
	error("A non sdp.");
end

A(2:n,1) = A(2:n,1) / A(1,1);

for j = 2:n
	v = ( A(j,1:j-1)' ) .* diag(A(1:j-1,1:j-1));
	A(j,j) = A(j,j) - A(j,1:j-1)*v;
	if A(j,j) <= 0
		error("A non sdp.");
	end
	A(j+1:n,j) = ( A(j+1:n,j) - A(j+1:n, 1:j-1)*v ) / A(j,j);
end
L = normalizationEngine("normalizeLowerTriangular", A, 1);

D = normalizationEngine("normalizeLowerTriangular", A, 0);
D = normalizationEngine("normalizeUpperTriangular", D, 0);
endfunction
