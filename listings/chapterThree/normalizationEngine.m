## normalizationEngine

function [ ret ] = normalizationEngine (narmalizationName, B, setUnaryDiagonal)
ret = feval(narmalizationName, B, setUnaryDiagonal);
endfunction


function [ normalized ] = normalizeLowerTriangular (B, setUnaryDiagonal)
	n = length(B);
	normalized = B;
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
	n = length(B);
	normalized = B;
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
