function [] = chebyshevAscissePlotter ()

  # build the ascisse vector
  ascisse = buildChebyshevAscisse(-10, 20, 100);
  ascisseForProjection = linspace(-10, 20, 100);
  
  # plot the errors
  plot(ascisse, zeros(length(ascisse),1) , "b+", ...
    ascisseForProjection, ascisse, "r+");
  grid;
  print "ChecyshevAscissePlotOutput.tex" '-dTex' '-S800, 600';
  
   # build the ascisse vector
  ascisse = buildChebyshevAscisse(-1, 1, 100);
  ascisseForProjection = linspace(-1, 1, 100);
  
  # plot the errors
  plot(ascisse, zeros(length(ascisse),1) , "b+", ...
    ascisseForProjection, ascisse, "r+");
  grid;
  print "ChecyshevAscisseUnaryPlotOutput.tex" '-dTex' '-S800, 600';
endfunction
