function [rungeEvaluationInterval, rungeEvaluatedFunctionValuesVector,...
    rungeInterpolationAscisseVector, rungeFunctionValuesVector,...
    rungeNormalInterpolatedValues, rungeNotAKnotInterpolatedValues] = ...
    exercise419runge(evaluateSetDimension, numberOfAscisse)

    rungeIntervalMagnitude = 5;
    rungeEvaluationInterval = linspace(-rungeIntervalMagnitude, ...
        rungeIntervalMagnitude, evaluateSetDimension)';

    # have the same dimension
    rungeEvaluatedFunctionValuesVector = rungeEvaluationInterval;
    
     # build the real functions values for evaluate real functions
    for i=1:evaluateSetDimension
        rungeEvaluatedFunctionValuesVector(i) = rungeRealFunction(...
            rungeEvaluationInterval(i));
    end 

    # build the partition vector and its associated vector of interpolation conditions
    rungeInterpolationAscisseVector = linspace(-rungeIntervalMagnitude, ...
        rungeIntervalMagnitude, numberOfAscisse)';
    for i=1:length(rungeInterpolationAscisseVector)
        rungeFunctionValuesVector(i) = rungeRealFunction(...
            rungeInterpolationAscisseVector(i));
    end    

    # setting up the parameter to drive the cubic splain engine.
    splainSchemeMatrixToFactorStrategyName = 'normalSplainScheme_BuildMatrixToFactor';
    splainSchemeMisStrategyName = 'normalSplainScheme_BuildMisVector';

    # go!
    [hVector, varPhiVector, xiVector, lVector, uVector, lowerBiadiagonalMatrix, ...
        upperBiadiagonalMatrix, diffDiviseVector, mis, rungeNormalInterpolatedValues] = ...
        cubicSplainEngine(rungeInterpolationAscisseVector, rungeFunctionValuesVector, ...
        splainSchemeMatrixToFactorStrategyName, splainSchemeMisStrategyName, rungeEvaluationInterval);

    # setting up the parameter to drive the cubic splain engine.
    splainSchemeMatrixToFactorStrategyName = 'notAKnotSplainScheme_BuildMatrixToFactor';
    splainSchemeMisStrategyName = 'notAKnotSplainScheme_BuildMisVector';

    [hVector, varPhiVector, xiVector, lVector, uVector, lowerBiadiagonalMatrix, ...
        upperBiadiagonalMatrix, diffDiviseVector, mis, rungeNotAKnotInterpolatedValues] = ...
        cubicSplainEngine(rungeInterpolationAscisseVector, rungeFunctionValuesVector, ...
        splainSchemeMatrixToFactorStrategyName, splainSchemeMisStrategyName, rungeEvaluationInterval);
    
endfunction

endfunction

function [y] = rungeRealFunction(x)
    y = 1/(1 + x^(2));
endfunction
