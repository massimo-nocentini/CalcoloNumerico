# functionExercise332.m

function [ unknownsMatrix, givenUnknownsMatrix ] = functionExercise332 (printPlots)
gamma = [10 1 .5 .1 .05 .01 .005 .001];
x = linspace(0, 10, 101)';
A = [x x.^0 ];
unknownsMatrix = [];
residueMatrix = [];

givenUnknownsMatrix = [];
givenResidueMatrix = [];

for i = 1:length(gamma)
	y = evaluatingFunction(x, gamma(i));
	[houseHolderVectors, Rhat, R, Q, g1, g2, unknowns, residue] = QRmethod(A,y);	
	unknownsMatrix = [unknownsMatrix unknowns];
	residueMatrix = [residueMatrix residue];
	
	# confronto con codice dato
	a = A\y;
	givenUnknownsMatrix = [givenUnknownsMatrix a];
	r = A * a - y;
	givenResidueMatrix = [givenResidueMatrix r]; 
end

if printPlots == 1
	
	residueRows = rows(residueMatrix);
	unknownsRows = rows(unknownsMatrix);
	
	gammaIndex = 1;
	plot(x, evaluatingFunction(x, gamma(gammaIndex)), "c", x, residueMatrix(1:residueRows, gammaIndex), x, givenResidueMatrix(1:residueRows, gammaIndex), "r", unknownsMatrix(1:unknownsRows,gammaIndex), evaluatingFunction(unknownsMatrix(1:unknownsRows,gammaIndex), gamma(gammaIndex)), "b+", givenUnknownsMatrix(1:unknownsRows,gammaIndex), evaluatingFunction(givenUnknownsMatrix(1:unknownsRows,gammaIndex), gamma(gammaIndex)), "g+");
	axis([-1, 11, -20, 120]);
	print 'exer332gamma10.tex' '-dTex' '-S800, 600';
	
	gammaIndex = 3;
	plot(x, evaluatingFunction(x, gamma(gammaIndex)), "c", x, residueMatrix(1:residueRows, gammaIndex), x, givenResidueMatrix(1:residueRows, gammaIndex), "r", unknownsMatrix(1:unknownsRows,gammaIndex), evaluatingFunction(unknownsMatrix(1:unknownsRows,gammaIndex), gamma(gammaIndex)), "b+", givenUnknownsMatrix(1:unknownsRows,gammaIndex), evaluatingFunction(givenUnknownsMatrix(1:unknownsRows,gammaIndex), gamma(gammaIndex)), "g+");
	axis([-1, 11, -20, 120]);
	print 'exer332gamma5e-1.tex' '-dTex' '-S800, 600';
	
	gammaIndex = 4;
	plot(x, evaluatingFunction(x, gamma(gammaIndex)), "c", x, residueMatrix(1:residueRows, gammaIndex), x, givenResidueMatrix(1:residueRows, gammaIndex), "r", unknownsMatrix(1:unknownsRows,gammaIndex), evaluatingFunction(unknownsMatrix(1:unknownsRows,gammaIndex), gamma(gammaIndex)), "b+", givenUnknownsMatrix(1:unknownsRows,gammaIndex), evaluatingFunction(givenUnknownsMatrix(1:unknownsRows,gammaIndex), gamma(gammaIndex)), "g+");
	axis([-1, 11, -20, 120]);
	print 'exer332gammae-1.tex' '-dTex' '-S800, 600';
	
	gammaIndex = 8;
	plot(x, evaluatingFunction(x, gamma(gammaIndex)), "c", x, residueMatrix(1:residueRows, gammaIndex), x, givenResidueMatrix(1:residueRows, gammaIndex), "r", unknownsMatrix(1:unknownsRows,gammaIndex), evaluatingFunction(unknownsMatrix(1:unknownsRows,gammaIndex), gamma(gammaIndex)), "b+", givenUnknownsMatrix(1:unknownsRows,gammaIndex), evaluatingFunction(givenUnknownsMatrix(1:unknownsRows,gammaIndex), gamma(gammaIndex)), "g+");
	axis([-1, 11, -20, 120]);
	print 'exer332gammae-3.tex' '-dTex' '-S800, 600';
end
endfunction

function [ ret ] = evaluatingFunction (x, gamma)
ret = 10*x + 5 + (sin(x*pi))*gamma;
endfunction

