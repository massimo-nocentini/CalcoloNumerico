## this function allow the generation of the plot for the function 5.17 on textbook.
function [] = analizer517()
  ## creation of the range where we compute the function and it's derivates
  points = linspace(0.5, 100, 10001);

  ## initialization of the vectors that host the computed values.
  functionValues = points;
  secondDerValues = points;
  fourthDerValues = points;
  
  for i=1:length(points)
    currentPoint = points(i);
    functionValues(i) = function517(currentPoint);
    secondDerValues(i) = secondDer517(currentPoint);
    fourthDerValues(i) = fourthDer517(currentPoint);
  end
  
  ## now we can plot the results
  semilogx(
    points, functionValues, "b");
  grid;
  print 'analysisFunction517-PlotOutput.tex' '-dTex' '-S800, 600';
  
  ## now we can plot the results
  loglog(
    points, functionValues, "b", ...
    points, secondDerValues, "r", ...
    points, fourthDerValues, "g");
  grid;
  print 'analysisFunction517WithDers-PlotOutput.tex' '-dTex' '-S800, 600';
  
  
endfunction
