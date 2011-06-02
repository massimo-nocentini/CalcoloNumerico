function [] = exercise419()

    evaluateSetDimension = 10^(4);

    # build the error vector
    errorVector = [10:10:50];
    errorVectorDimension = length(errorVector);

    normalRungeErrorVector = ones(errorVectorDimension,1);
    notAKnotRungeErrorVector = ones(errorVectorDimension,1);

    normalBernsteinErrorVector = ones(errorVectorDimension,1);
    notAKnotBernsteinErrorVector = ones(errorVectorDimension,1);
    
    # start from 1 to have at least one ascisse for Bernstein interval domain.
    for n=1:errorVectorDimension

        [rungeEvaluationInterval, rungeEvaluatedFunctionValuesVector,...
        rungeInterpolationAscisseVector, rungeFunctionValuesVector,...
        rungeNormalInterpolatedValues, rungeNotAKnotInterpolatedValues] = ...
            exercise419runge(evaluateSetDimension, errorVector(n));

        [bernsteinEvaluationInterval, bernsteinEvaluatedFunctionValuesVector,...
        bernsteinInterpolationAscisseVector, bernsteinFunctionValuesVector,...
        bernsteinNormalInterpolatedValues, bernsteinNotAKnotInterpolatedValues] =...
            exercise419bernstein(evaluateSetDimension, errorVector(n));

        # calculate the error
        normalRungeErrorVector(n) = max(abs(rungeEvaluatedFunctionValuesVector ...
             - rungeNormalInterpolatedValues));

        notAKnotRungeErrorVector(n) = max(abs(rungeEvaluatedFunctionValuesVector ...
             - rungeNotAKnotInterpolatedValues));

        normalBernsteinErrorVector(n) = max(abs(bernsteinEvaluatedFunctionValuesVector ...
             - bernsteinNormalInterpolatedValues));

        notAKnotBernsteinErrorVector(n) = max(abs(bernsteinEvaluatedFunctionValuesVector ...
             - bernsteinNotAKnotInterpolatedValues));

    end

    semilogy(errorVector, normalRungeErrorVector, "b", ...
        errorVector, notAKnotRungeErrorVector, "r");
    grid;
    print 'exercise419-rungeErrorsPlotOutput.tex' '-dTex' '-S800, 600';
    
    semilogy(errorVector, normalBernsteinErrorVector, "b", ...
        errorVector, notAKnotBernsteinErrorVector, "r");
    grid;
    print 'exercise419-bernsteinErrorsPlotOutput.tex' '-dTex' '-S800, 600';

endfunction
