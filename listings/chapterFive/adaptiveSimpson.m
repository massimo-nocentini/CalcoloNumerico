function [i2, points, err] = adaptiveSimpson(a, b, functionName,...
  tol, fa, fb, middle, fmiddle)
  
  ## to enable recursion
  global points;
  
  ## compute the function value on the limits
  if nargin < 8
    middle = (a + b)/2;
    points = [a, b, middle];
    fa = feval(functionName, a);
    fb = feval(functionName, b);
    fmiddle = feval(functionName, middle);
  end
  
  h = b - a;
  newPointLeft = (a + middle)/2;
  newPointRight = (middle + b)/2;
  
  ## add the new point to the points collection
  points = [points, newPointLeft, newPointRight];
  
  ## evaluate in new computed point
  newPointLeftEvaluation = feval(functionName, newPointLeft);
  newPointRightEvaluation = feval(functionName, newPointRight);
  
  ## compute without subintervals
  i1 = (1/6) * h * (fa + 4 * fmiddle + fb);
  
  ## multiply by .5 because the terms with even index are already managed in i1
  ## so to have (1/12) = (1/6)(1/2) required by the general equation (5.15).
  ## for the items with odd index we have to multiply by 4 as required.
  #i2 = (1/12) * h * (4 *(newPointLeftEvaluation + newPointRightEvaluation) + ...
  #  (fa + 2 * fmiddle + fb));
  
  i2 = (1/12) * h * 4 * (newPointLeftEvaluation + newPointRightEvaluation) + ...
    (1/2) * i1 - (2/12) * h * fmiddle;
 
  ## according to (5.19)
  err = abs(i2 - i1)/15;

  if err > tol && abs(b-a) > eps && tol > eps
    [i2left, points, errLeft] = adaptiveSimpson(a, middle, functionName, ...
      tol/2, fa, fmiddle, newPointLeft, newPointLeftEvaluation);
      
    [i2right, points, errRight] = adaptiveSimpson(middle, b, functionName, ...
      tol/2, fmiddle, fb, newPointRight, newPointRightEvaluation);
      
    i2 = i2left + i2right;
    
    err = errLeft + errRight;
  end
  
  ## se sono alla prima chiamata allora posso riordinare i punti
  if nargin < 8
    points = sort(points);
  end

endfunction
