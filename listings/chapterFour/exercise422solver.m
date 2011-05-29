function [] = exercise422solver ()
  
  x = [0:1:10]';
  A = [x x.^0 ];
  
  # sperimental data
  y = [5.22 4.00 4.28 3.89 3.53 3.12 2.73 2.70 2.20 2.08 1.94]';
  
  # in quanto ho effettuato il cambio di variabile \rho
  y = log(y);
  
  # applico la fattorizzazione QR
	[houseHolderVectors, Rhat, R, Q, g1, g2, unknowns, residue] = QRmethod(A,y);	
	# mostro il valore dei coefficienti incogniti (indice piu' basso corrisponde al
	# coefficiente del termine di grado piu' alto)
	unknowns
	
	# costruisco una partizione fissa per poter costruire il plot
	ascisseForPlot = linspace(-1, 11, 200)';
  minimalSquaresEvaluation = evaluatingMinimalSquaresLine(ascisseForPlot,...
    unknowns(1), unknowns(2));

  # non c'e' bisogno di fare la singola operazione di exp sui due termini della
  # retta ai minimi quadrati, in quanto per le prop dell'esponenziale 
  # exp(a+b) = exp(a)exp(b), quindi eseguendo su tutto il valore calcolato dovremo
  # risolvere il problema
  minimalSquaresEvaluation = exp(minimalSquaresEvaluation);
  
  #residuePoints = residue + exp(evaluatingMinimalSquaresLine(x,...
  #  unknowns(1), unknowns(2)));
    
  # plot time!
  plot(x, exp(y), "r+", ...
    #x, residuePoints , "g+",...
    ascisseForPlot, minimalSquaresEvaluation, "b");
  print 'exercise422-PlotOutput.tex' '-dTex' '-S800, 600';

endfunction

function [ ret ] = evaluatingMinimalSquaresLine (x, alpha, beta)
ret = alpha*x + beta;
endfunction
