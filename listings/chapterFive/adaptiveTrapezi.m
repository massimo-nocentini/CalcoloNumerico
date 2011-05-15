function [i2, points, err] = adaptiveTrapezi(a, b, functionName,...
  tol, fa, fb)
  
  ## to enable recursion
  global points;
  
  ## compute the function value on the limits
  if nargin < 6
    points = [a, b];
    fa = feval(functionName, a);
    fb = feval(functionName, b);
  end
  
  h = b - a;
  newPoint = (a + b)/2;
  
  ## add the new point to the points collection
  points = [points, newPoint];
  
  ## evaluate in new computed point
  newPointEvaluation = feval(functionName, newPoint);
  
  ## compute without subintervals
  i1 = .5 * h * (fa + fb);
  
  ## compute with intervals
  i2 = .5 * (i1 + h * newPointEvaluation);
  
  ## according to (5.18)
  err = abs(i2 - i1)/3;
  
  if err > tol
    [i2left, points, errLeft] = adaptiveTrapezi(a, newPoint, functionName, ...
      tol/2, fa, newPointEvaluation);
      
    [i2right, points, errRight] = adaptiveTrapezi(newPoint, b, functionName, ...
      tol/2, newPointEvaluation, fb);
      
    i2 = i2left + i2right;
    
    err = errLeft + errRight;
  end
  
  ## se sono alla prima chiamata allora posso riordinare i punti
  if nargin < 6
    points = sort(points);
  end

endfunction
