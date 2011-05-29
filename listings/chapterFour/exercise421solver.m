function [] = exercise421solver ()
  gamma = 2.5;
  x = linspace(0, 10, 101)';
  A = [x x.^0 ];
  
  y = evaluatingFunction(x, gamma);
	[houseHolderVectors, Rhat, R, Q, g1, g2, unknowns, residue] = QRmethod(A,y);	
	unknowns
  minimalSquaresEvaluation = evaluatingMinimalSquaresLine(x, unknowns(1), unknowns(2));

  plot(x, y, "r", x, minimalSquaresEvaluation, "b");
  print 'exercise421-PlotOutput.tex' '-dTex' '-S800, 600';

endfunction

function [ ret ] = evaluatingFunction (x, gamma)
ret = 10*x + 5 + (sin(x*pi))*gamma;
endfunction

function [ ret ] = evaluatingMinimalSquaresLine (x, alpha, beta)
ret = alpha*x + beta;
endfunction
