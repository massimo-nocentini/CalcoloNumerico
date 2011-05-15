function [trapeziCompositeResultTable, simpsonCompositeResultTable] = ...
  exercise59solver()

  b = 100;
  a = .5;
  
  ## the first row is only for initializing the result table
  trapeziCompositeResultTable = [-1 -1 -1];
  simpsonCompositeResultTable = [-1 -1 -1];
  for intervalQty=1000:1000:10000
    ######################### for trapezi method #########################
    [points, evaluatedFunctionValues, errore, integralValue] = ...
      trapeziComposita('function517', 'secondDer517', intervalQty, a, b);
    
    trapeziCompositeResultTable = [trapeziCompositeResultTable; ...
      intervalQty integralValue errore];
      
    ######################### for simpson method #########################
    [points, evaluatedFunctionValues, errore, integralValue] = ...
      simpsonComposita('function517', 'fourthDer517', intervalQty, a, b);
    
    simpsonCompositeResultTable = [simpsonCompositeResultTable; ...
      intervalQty integralValue errore];
  end
  
  ######################### cleaning the results #########################
  trapeziCompositeResultTable = trapeziCompositeResultTable(2:...
    rows(trapeziCompositeResultTable), :);
    
  simpsonCompositeResultTable = simpsonCompositeResultTable(2:...
    rows(simpsonCompositeResultTable), :);
endfunction
