function [points, evaluatedFunctionValues, errore, integralValue] = ...
    trapeziComposita(fName, derSecondaName, intervalQty, a, b)

    # build the vector that keeps track about the point in which the function
    # will be evaluated
    points = linspace(a, b, intervalQty + 1);

    # setting up the vector for hosting the evaluation of f in each point 
    # in points
    evaluatedFunctionValues = points;

    # compute a summation of the internal values, which are doubly counted
    valueSummation = 0;
    
    pointsLength = length(points);
    for i = 2:(pointsLength-1)
    
        # evaluate in each point
        currentEvaluation = feval(fName, points(i));
        evaluatedFunctionValues(i) = currentEvaluation;

        # add to the summation: observe that here we perform only one addition
        valueSummation = valueSummation + currentEvaluation;
    end

    # doubling the summation performed till now, instead of adding two copies
    # inside the for loop
    valueSummation = valueSummation * 2;

    # evaluating in the initial and final points too
    f0 = feval(fName, points(1));
    evaluatedFunctionValues(1) = f0;

    fn = feval(fName, points(pointsLength));
    evaluatedFunctionValues(pointsLength) = fn;

    valueSummation = valueSummation + f0 + fn;

    # compute the integral value
    integralValue = ((b-a)/(2*intervalQty)) * valueSummation;

    # compute the error
    somePointForErrorEvaluation = 1;
    errore = -(intervalQty/12)*feval(derSecondaName, somePointForErrorEvaluation) *...
        ((b-a)/intervalQty)^3;

endfunction
