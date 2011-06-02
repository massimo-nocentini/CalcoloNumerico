function [domain, rungeErrorVector, bernsteinErrorVector, ...
    rungeEvaluationIntervalOutput, rungeInterpolatedOrdinateVectorOutput,...
    bernsteinEvaluationIntervalOutput, bernsteinInterpolatedOrdinateVectorOutput] = ...
      exercises411415CommonFactor(errorIntervalVector, ascisseCreationFunctionName)

    # build the vectors for valuate the interpolation and study the error.
    evaluateSetDimension = 10^(3);
    rungeEvaluationInterval = linspace(-5, 5, evaluateSetDimension)';
    bernsteinEvaluationInterval = linspace(-1, 1, evaluateSetDimension)';

    # have the same dimension
    rungeEvaluatedFunctionValuesVector = rungeEvaluationInterval;
    bernsteinEvaluatedFunctionValuesVector = bernsteinEvaluationInterval;
    
     # build the real functions values for evaluate real functions
    rungeEvaluatedFunctionValuesVector = rungeRealFunction(...
      rungeEvaluationInterval);
    bernsteinEvaluatedFunctionValuesVector = bernsteinRealFunction(...
      bernsteinEvaluationInterval);

    # get the error vector dimension
    errorVectorDimension = length(errorIntervalVector);
    
    # initializing the vectors with a dummy value
    rungeErrorVector = ones(errorVectorDimension,1);
    bernsteinErrorVector = ones(errorVectorDimension,1);

    # start from 1 to have at least one ascisse for Bernstein interval domain.
    for i=1:errorVectorDimension

        # current number of ascisse to build the approximation
        # +1 because n is the rank, n+1 are the ascisse
        n = errorIntervalVector(i) + 1;
        
        # build the ascisse where I want to interpolate the functions
        # the limits {-5, 5, -1, 1} are fixed by definition of the exercise
        # fix the length of the set of interpolation ascisse
        # using the strategy that is passed as parameter
        rungeInterpolationAscisseVector = feval(ascisseCreationFunctionName, ...
            -5, 5, n)';
        bernsteinInterpolationAscisseVector = feval(ascisseCreationFunctionName, ...
            -1, 1, n)';

        # compute the function values on each interpolation ascisse       
        rungeInterpolationOrdinateVector = rungeRealFunction(...
            rungeInterpolationAscisseVector);
        bernsteinInterpolationOrdinateVector = bernsteinRealFunction(...
            bernsteinInterpolationAscisseVector);

        # compute the differenze divise vectors for the two functions.
        rungeDifferenzeDiviseVector = differenzeDiviseEngine(...
          rungeInterpolationAscisseVector, rungeInterpolationOrdinateVector);
        bernsteinDifferenzeDiviseVector = differenzeDiviseEngine(...
            bernsteinInterpolationAscisseVector, bernsteinInterpolationOrdinateVector);

        # compute the polynomion and valuate on an interval
        rungeInterpolatedOrdinateVector = HornerGeneralizzato(...
            rungeEvaluationInterval, ...
            rungeInterpolationAscisseVector, rungeDifferenzeDiviseVector);
        bernsteinInterpolatedOrdinateVector = HornerGeneralizzato(...
            bernsteinEvaluationInterval, ...
            bernsteinInterpolationAscisseVector, bernsteinDifferenzeDiviseVector);

        if i == errorVectorDimension
          # saving the value for output and outside plot the approximated functions
          rungeEvaluationIntervalOutput = rungeEvaluationInterval;
          rungeInterpolatedOrdinateVectorOutput = rungeInterpolatedOrdinateVector;
          
          bernsteinEvaluationIntervalOutput = bernsteinEvaluationInterval;
          bernsteinInterpolatedOrdinateVectorOutput = ...
            bernsteinInterpolatedOrdinateVector;
        end

        # calculate the error
        rungeErrorVector(i) = max(abs(rungeEvaluatedFunctionValuesVector ...
             - rungeInterpolatedOrdinateVector));             
        bernsteinErrorVector(i) = max(abs(bernsteinEvaluatedFunctionValuesVector ...
             - bernsteinInterpolatedOrdinateVector));

    end
       
    # costruisco il dominio su cui rappresentare gli errori commessi
    domain = [1:1:errorVectorDimension];
    
endfunction

function [y] = rungeRealFunction(x)
    y = 1./(1 .+ x.^(2));
endfunction

function [y] = bernsteinRealFunction(x)
    y = abs(x);
endfunction
