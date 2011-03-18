function [] = exercise411()

    # build the vectors for valuate the interpolation and study the error.
    evaluateSetDimension = 100;
    rungeEvaluationInterval = linspace(-5, 5, evaluateSetDimension)';
    bernsteinEvaluationInterval = linspace(-1, 1, evaluateSetDimension)';

    # have the same dimension
    rungeEvaluatedFunctionValuesVector = rungeEvaluationInterval;
    bernsteinEvaluatedFunctionValuesVector = bernsteinEvaluationInterval;
    
     # build the real functions values for evaluate real functions
    for i=1:evaluateSetDimension
        rungeEvaluatedFunctionValuesVector(i) = rungeRealFunction(...
            rungeEvaluationInterval(i));

        bernsteinEvaluatedFunctionValuesVector(i) = bernsteinRealFunction(...
            bernsteinEvaluationInterval(i));
    end 

    # build the error vector
    errorVectorDimension = 100;
    rungeErrorVector = ones(errorVectorDimension,1);
    bernsteinErrorVector = ones(errorVectorDimension,1);

    # start from 1 to have at least one ascisse for Bernstein interval domain.
    for n=1:errorVectorDimension

        # build the ascisse where I want to interpolate the functions
        # the limits {-5, 5, -1, 1} are fixed by definition of the exercise
        # fix the length of the set of interpolation ascisse
        #ascisseDimension = 10;
        rungeInterpolationAscisseVector = linspace(-5, 5, n)';
        bernsteinInterpolationAscisseVector = linspace(-1, 1, n)';

        # setup the arrays of function values with the correct dimensions
        rungeInterpolationOrdinateVector = rungeInterpolationAscisseVector;
        bernsteinInterpolationOrdinateVector = bernsteinInterpolationAscisseVector;

        # build the real functions values for building the interpolation polynomion
        for i=1:n
            rungeInterpolationOrdinateVector(i) = rungeRealFunction(...
                rungeInterpolationAscisseVector(i));

            bernsteinInterpolationOrdinateVector(i) = bernsteinRealFunction(...
                bernsteinInterpolationAscisseVector(i));
        end    

        # compute the differenze divise vectors for the two functions.
        rungeDifferenzeDiviseVector = differenzeDiviseEngine(rungeInterpolationAscisseVector, ...
            rungeInterpolationOrdinateVector);

        bernsteinDifferenzeDiviseVector = differenzeDiviseEngine(...
            bernsteinInterpolationAscisseVector, bernsteinInterpolationOrdinateVector);

        # compute the polynomion and valuate on an interval
        rungeInterpolatedOrdinateVector = HornerGeneralizzato(rungeEvaluationInterval, ...
            rungeInterpolationAscisseVector, rungeDifferenzeDiviseVector);

        bernsteinInterpolatedOrdinateVector = HornerGeneralizzato(bernsteinEvaluationInterval, ...
            bernsteinInterpolationAscisseVector, bernsteinDifferenzeDiviseVector);

        # calculate the error
        rungeErrorVector(n) = max(abs(rungeEvaluatedFunctionValuesVector ...
             - rungeInterpolatedOrdinateVector));
        bernsteinErrorVector(n) = max(abs(bernsteinEvaluatedFunctionValuesVector ...
             - bernsteinInterpolatedOrdinateVector));

    end

    # plot the errors
    domain = [1:1:errorVectorDimension]';
    semilogy(domain, rungeErrorVector, "b", ...
        domain, bernsteinErrorVector, "r");
    grid;
    print 'exercise411-ErrorsSemilogYPlotOutput.tex' '-dTex' '-S800, 600';

    loglog(domain, rungeErrorVector, "b", ...
        domain, bernsteinErrorVector, "r");
    grid;
    print 'exercise411-ErrorsLoglogPlotOutput.tex' '-dTex' '-S800, 600';

endfunction

function [y] = rungeRealFunction(x)
    y = 1/(1 + x^(2));
endfunction

function [y] = bernsteinRealFunction(x)
    y = abs(x);
endfunction
