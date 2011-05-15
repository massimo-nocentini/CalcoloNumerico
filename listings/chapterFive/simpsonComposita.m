function [points, evaluatedFunctionValues, errore, integralValue] = ...
    simpsonComposita(fName, derQuartaName, intervalQty, a, b)

    # build the vector that keeps track about the point in which the function
    # will be evaluated
    points = linspace(a, b, intervalQty + 1);

    # setting up the vector for hosting the evaluation of f in each point 
    # in points
    evaluatedFunctionValues = points;

    # compute a summation of the internal values, which are doubly counted
    oddValueSummation = 0;
    evenValueSummation = 0;
    
    pointsLength = length(points);
    for i = 2:(intervalQty/2) # Do is right use intervalQty? Use pointsLength instead?
        # evaluate in each point
        # here instead of -1 we use -2 because Octave's vectors are 1-based
        currentEvaluation = feval(fName, points(2*i-2));

        # add to the summation: observe that here we perform only one addition
        oddValueSummation = oddValueSummation + currentEvaluation;
    end

    for i = 1:(intervalQty/2) # Do is right use intervalQty? Use pointsLength instead?
        # evaluate in each point
        # here instead of 0 we use -1 because Octave's vectors are 1-based
        currentEvaluation = feval(fName, points(2*i - 1));

        # add to the summation: observe that here we perform only one addition
        evenValueSummation = evenValueSummation + currentEvaluation;
    end

    for i = 1:pointsLength
        # evaluate in each point
        evaluatedFunctionValues(i) = feval(fName, points(i));
    end

    # evaluating in the initial and final points too
    f0 = feval(fName, points(1));
    fn = feval(fName, points(pointsLength));

    valueSummation = 4 * oddValueSummation + 2 * evenValueSummation -(f0 + fn);

    # compute the integral value
    integralValue = ((b-a)/(3*intervalQty)) * valueSummation;

    # compute the error
    somePointForErrorEvaluation = 1;
    errore = -(intervalQty/180)*feval(derQuartaName, somePointForErrorEvaluation) *...
        ((b-a)/intervalQty)^5;

endfunction
