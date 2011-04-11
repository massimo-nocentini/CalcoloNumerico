function [] = exercise419runge()

    # build the vectors for valuate the interpolation and study the error.
    evaluateSetDimension = 300;
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
    interpolationAscisseVector = linspace(-rungeIntervalMagnitude, rungeIntervalMagnitude, 10)';
    for i=1:length(interpolationAscisseVector)
        functionValuesVector(i) = rungeRealFunction(...
            interpolationAscisseVector(i));
    end    

    # setting up the parameter to drive the cubic splain engine.
    splainSchemeMatrixToFactorStrategyName = 'normalSplainScheme_BuildMatrixToFactor';
    splainSchemeMisStrategyName = 'normalSplainScheme_BuildMisVector';

    # go!
    [hVector, varPhiVector, xiVector, lVector, uVector, lowerBiadiagonalMatrix, ...
        upperBiadiagonalMatrix, diffDiviseVector, mis, normalInterpolatedValues] = ...
        cubicSplainEngine(interpolationAscisseVector, functionValuesVector, ...
        splainSchemeMatrixToFactorStrategyName, splainSchemeMisStrategyName, rungeEvaluationInterval);

    # setting up the parameter to drive the cubic splain engine.
    splainSchemeMatrixToFactorStrategyName = 'notAKnotSplainScheme_BuildMatrixToFactor';
    splainSchemeMisStrategyName = 'notAKnotSplainScheme_BuildMisVector';

    [hVector, varPhiVector, xiVector, lVector, uVector, lowerBiadiagonalMatrix, ...
        upperBiadiagonalMatrix, diffDiviseVector, mis, notAKnotInterpolatedValues] = ...
        cubicSplainEngine(interpolationAscisseVector, functionValuesVector, ...
        splainSchemeMatrixToFactorStrategyName, splainSchemeMisStrategyName, rungeEvaluationInterval);

    plot(rungeEvaluationInterval, rungeEvaluatedFunctionValuesVector, "b", ...
        rungeEvaluationInterval, normalInterpolatedValues, "r", ...
        rungeEvaluationInterval, notAKnotInterpolatedValues, "g", ...
        interpolationAscisseVector, functionValuesVector, "+");
    grid;
    print 'exercise419-rungeInterpolationPlotOutput.tex' '-dTex' '-S800, 600';
    
endfunction

endfunction

function [y] = rungeRealFunction(x)
    y = 1/(1 + x^(2));
endfunction

function [y] = bernsteinRealFunction(x)
    y = abs(x);
endfunction
