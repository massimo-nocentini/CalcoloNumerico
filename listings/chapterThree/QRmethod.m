## QRmethod

function [ hhvectors, Rhat, R, Q, g1, g2, unknowns, residue ] = QRmethod (A, b)
[ hhvectors, Rhat] = factorQR(A);
Q = buildQOrthogonalMatrix(hhvectors);
g = (Q') * b;

R = Rhat(1:columns(Rhat), 1:columns(Rhat));
g1 = g(1:columns(Rhat));
g2 = g(columns(Rhat)+1:rows(g));
unknowns = triangularSystemSolver(R, g1, "upperSolveEngine");
residue = Q*Rhat*unknowns - b;
endfunction

function [houseHolderVectors, R] = factorQR (A)
n = columns(A);
m = rows(A);

for i = 1:n
	alpha = norm(A(i:m, i));
	
	if alpha == 0
		error("rank(A) ~= n. A non ha rango massimo");
	end

	if A(i,i) > 0
		alpha = -alpha;
	end
	
	v1 = A(i,i) - alpha;
	A(i,i) = alpha;
	A(i+1:m, i) = A(i+1:m, i) / v1;
	
	beta = -(v1/alpha);
	A(i:m, i+1:n) = A(i:m, i+1:n) - (beta * [1; A(i+1:m, i)]) * ([1, A(i+1:m, i)'] * A(i:m, i+1:n)); 
end
B = A;
houseHolderVectors = A;
for i = 1:n
	if i > 1
		houseHolderVectors(1:i-1, i) = 0;
	end
	
	houseHolderVectors(i, i) = 1;
end

R = normalizationEngine("normalizeUpperTriangular", A, 0);
R = [R; zeros(m-n,n)];
endfunction

function [ Q ] = buildQOrthogonalMatrix (houseHolderVectors)
m = rows(houseHolderVectors);
n = columns(houseHolderVectors);
Q = eye(m, m);
for i = 1:n
	Q = Q * buildHElementaryMatrix(houseHolderVectors(1:m, i)); # it is important to multiply Q at left side
end 
endfunction

function [ elementaryMatrix ] = buildHElementaryMatrix (houseHolderVector)
elementaryMatrix = eye(length(houseHolderVector)) - 2 * ((houseHolderVector * (houseHolderVector'))/((houseHolderVector') * houseHolderVector)); 
endfunction