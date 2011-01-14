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

	# alpha >= 0 per definizione di norma.
	alpha = norm(A(i:m, i));
	
	if alpha == 0
		error("rank(A) ~= n. A non ha rango massimo");
	end

	# A(i,i) e' il primo elemento della colonna i-esima.
	if A(i,i) > 0
		# inverto il segno di alpha in quanto alpha e' positivo per definizione 
		# di norma, quindi per evitare il fenomeno della cancellazione numerica,
		# cambio di segno in quanto nella prossima istruzione cambio di nuovo
		# segno.
		alpha = -alpha;
	end
	
	# considero il primo elemento del vettore che voglio manipolare con la
	# trasformazione ortogonale.
	v1 = A(i,i) - alpha;
	
	# setto il primo elemento in base a quanto richiesto nel metodo di Householder
	# ovvero H * v = alpha * e_{1}
	A(i,i) = alpha;
	
	# costruisco il vettore caratteristico di Householder, normalizzando
	# solo le componenti con indice j > i, in quanto il primo elemento (settato
	# nell'istruzione precedente) non deve essere modificato in quanto sara'
	# un elemento (sulla diagonale) della matrice R.
	A(i+1:m, i) = A(i+1:m, i) / v1;
	
	# evito di calcolare il prodotto scalare, vedi testo per l'uso di questo trick.
	beta = -(v1/alpha);
	
	# A(i:m, i+1:n) = ... dato che ho gia modificato la colonna i, adesso aggiorno
	# 	la restante parte della matrice, ovvero le colonne con indice j > i.
	# = A(i:m, i+1:n) parto dalle informazioni presenti nella matrice memorizzate
	# fino al passo (i-1)
	A(i:m, i+1:n) = A(i:m, i+1:n) ...
		
		# moltiplico il coefficiente beta per il vettore di Householder, il quale
		# lo costruisco con [1; A(i+1:m, i)], perche essendo normalizzato, la sua
		# prima componente e' per costruzione 1 (oss: se considerassi A(i:m, i)
		# come vettore caratteristico commetterei un errore perche A(i,i) = alpha
		# per l'assegnazione fatta precedentemente.
		- (beta * [1; A(i+1:m, i)]) ...
		
		# finisco di effettuare il prodotto tra il vettore caratteristico trasposto
		# e il vettore che voglio manipolare (azzerando tutte le componenti tranne la
		# prima). Questo vettore e' A(i:m, i+1:n), infatti si usa come primo indice
		# A(i:...) invece di A(i+1:...) come invece si usa per il vettore caratteristico.
		* ([1, A(i+1:m, i)'] * A(i:m, i+1:n)); 
end
B = A;
houseHolderVectors = A;

# costruisco i vettori caratteristici partendo dalla matrice modificata A. I vettori
# caratteristici sono 0 fino alla (i-1)-esima componente, 1 per la i-esima e 
# valori computati dal precedente ciclo dalla componente (i+1) in poi.
for i = 1:n
	if i > 1
		houseHolderVectors(1:i-1, i) = 0;
	end
	
	houseHolderVectors(i, i) = 1;
end

# uso la matrice A modificata per estrapolare le informazioni che costruiscono
# la matrice triangolare superiore R.
R = normalizationEngine("normalizeUpperTriangular", A, 0);

# finisco di costruire la matrice R aggiungendo una matrice nulla in coda
R = [R; zeros(m-n,n)];
endfunction

function [ Q ] = buildQOrthogonalMatrix (houseHolderVectors)
m = rows(houseHolderVectors);
n = columns(houseHolderVectors);
Q = eye(m, m);
# costruisco la matrice ortogonale Q = (H_n * ... * H_1)^{T} =H_1 * ... * H_n
# perche H_j e' simmetrica
# per ogni vettore caratteristico ricavo la relativa matrice di eliminazione e moltiplico
# a sinistra. 
for i = 1:n
	Q = Q * buildHElementaryMatrix(houseHolderVectors(1:m, i)); # it is important to multiply Q at left side
end 
endfunction

# questo oggetto matematico computa la i-esima matrice di eliminazione in funzione
# del vettore caratteristico passato come input. La costruzione segue la definizione
# teorica enumciata nel testo.
function [ elementaryMatrix ] = buildHElementaryMatrix (houseHolderVector)
elementaryMatrix = eye(length(houseHolderVector)) - 2 * ((houseHolderVector * (houseHolderVector'))/((houseHolderVector') * houseHolderVector)); 
endfunction