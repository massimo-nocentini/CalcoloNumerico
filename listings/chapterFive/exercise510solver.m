function [trapeziAdaptiveResultTable, simpsonAdaptiveResultTable] = ...
  exercise510solver()

  b = 100;
  a = .5;
  functionName = 'function517';
  
  ## the first row is only for initializing the result table
  trapeziAdaptiveResultTable = [-1 -1 -1];
  simpsonAdaptiveResultTable = [-1 -1 -1];
  
  ## initialize the data structures for store the information about the points
  ## considerated by the method and to be able to plot them
  lastTrapeziPoints = [];
  evaluatedLastTrapeziPoints = lastTrapeziPoints;
  
  lastSimpsonPoints = [];
  evaluatedLastSimpsonPoints = lastSimpsonPoints;
  
  tols=[10^(-1); 10^(-2); 10^(-3); 10^(-4); 10^(-5)];
  for i = 1:length(tols)
    ######################### for trapezi method #########################
    [i2, points, err] = adaptiveTrapezi(a, b, functionName, tols(i));
    
    trapeziAdaptiveResultTable = [trapeziAdaptiveResultTable; ...
      tols(i) err length(points)];
      
    ## save the desired computed points to show them in a plot selecting at which
    ## tol we want to capture the points
    if i == 3
      lastTrapeziPoints = points;
    end
    
    ######################### for simpson method #########################
    ## fix: infinite recursion :(
    [i2, points, err] = adaptiveSimpson(a, b, functionName, tols(i));
    
    simpsonAdaptiveResultTable = [simpsonAdaptiveResultTable; ...
      tols(i) err length(points)];
      
    ## save the desired computed points to show them in a plot selecting at which
    ## tol we want to capture the points
    if i == 4
      lastSimpsonPoints = points;
    end
  end
  
  ######################### cleaning the results for Trapezi ##################
  trapeziAdaptiveResultTable = trapeziAdaptiveResultTable(2:...
    rows(trapeziAdaptiveResultTable), :);
    
  for i = 1:length(lastTrapeziPoints)
    evaluatedLastTrapeziPoints(i) = feval(functionName, lastTrapeziPoints(i));
  end
  
  ######################### cleaning the results for Simpson ##################
  simpsonAdaptiveResultTable = simpsonAdaptiveResultTable(2:...
    rows(simpsonAdaptiveResultTable), :);
    
  for i = 1:length(lastSimpsonPoints)
    evaluatedLastSimpsonPoints(i) = feval(functionName, lastSimpsonPoints(i));
  end
  
  ## plotting
  semilogx(
    lastTrapeziPoints, evaluatedLastTrapeziPoints, "b+");
  grid;
  print 'exercise510-TrapeziAdaptivePlotOutput.tex' '-dTex' '-S800, 600';
  
  semilogx(
    lastSimpsonPoints, evaluatedLastSimpsonPoints, "r+");
  grid;
  print 'exercise510-SimpsonAdaptivePlotOutput.tex' '-dTex' '-S800, 600';
endfunction
