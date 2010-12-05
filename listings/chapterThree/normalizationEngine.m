## normalizationEngine

function [ ret ] = normalizationEngine (narmalizationName, B, setUnaryDiagonal)
ret = feval(narmalizationName, B, setUnaryDiagonal);
endfunction


function [ normalized ] = normalizeLowerTriangular (B, setUnaryDiagonal)
	n = columns(B);
	normalized = B(1:n, 1:n);
	for i = 1:n
		for j = 1:n
			if i < j
				normalized(i, j) = 0;			
			end
		end
	end
	
	if setUnaryDiagonal == 1
		for i = 1:n
			normalized(i,i) = 1;
		end	
	end
endfunction

function [ normalized ] = normalizeUpperTriangular (B, setUnaryDiagonal)
	n = columns(B);
	normalized = B(1:n, 1:n);
	for i = 1:n
		for j = 1:n
			if i > j
				normalized(i, j) = 0;			
			end
		end
	end
	
	if setUnaryDiagonal == 1
		for i = 1:n
			normalized(i,i) = 1;
		end	
	end
endfunction
