function [] = exercise419bernstein()

    # build the vectors for valuate the interpolation and study the error.
    evaluateSetDimension = 300;
    bernsteinIntervalMagnitude = 1;
    bernsteinEvaluationInterval = linspace(-bernsteinIntervalMagnitude, ...
        bernsteinIntervalMagnitude, evaluateSetDimension)';

    # have the same dimension
    bernsteinEvaluatedFunctionValuesVector = bernsteinEvaluationInterval;
    
     # build the real functions values for evaluate real functions
    for i=1:evaluateSetDimension
        bernsteinEvaluatedFunctionValuesVector(i) = bernsteinRealFunction(...
            bernsteinEvaluationInterval(i));
    end 

    # build the partition vector and its associated vector of interpolation conditions
    interpolationAscisseVector = linspace(-bernsteinIntervalMagnitude, bernsteinIntervalMagnitude, 10)';
    for i=1:length(interpolationAscisseVector)
        functionValuesVector(i) = bernsteinRealFunction(...
            interpolationAscisseVector(i));
    end    

    # setting up the parameter to drive the cubic splain engine.
    splainSchemeMatrixToFactorStrategyName = 'normalSplainScheme_BuildMatrixToFactor';
    splainSchemeMisStrategyName = 'normalSplainScheme_BuildMisVector';

    # go!
    [hVector, varPhiVector, xiVector, lVector, uVector, lowerBiadiagonalMatrix, ...
        upperBiadiagonalMatrix, diffDiviseVector, mis, normalInterpolatedValues] = ...
        cubicSplainEngine(interpolationAscisseVector, functionValuesVector, ...
        splainSchemeMatrixToFactorStrategyName, splainSchemeMisStrategyName, bernsteinEvaluationInterval);

    # setting up the parameter to drive the cubic splain engine.
    splainSchemeMatrixToFactorStrategyName = 'notAKnotSplainScheme_BuildMatrixToFactor';
    splainSchemeMisStrategyName = 'notAKnotSplainScheme_BuildMisVector';

    [hVector, varPhiVector, xiVector, lVector, uVector, lowerBiadiagonalMatrix, ...
        upperBiadiagonalMatrix, diffDiviseVector, mis, notAKnotInterpolatedValues] = ...
        cubicSplainEngine(interpolationAscisseVector, functionValuesVector, ...
        splainSchemeMatrixToFactorStrategyName, splainSchemeMisStrategyName, bernsteinEvaluationInterval);

    plot(bernsteinEvaluationInterval, bernsteinEvaluatedFunctionValuesVector, "b", ...
        bernsteinEvaluationInterval, normalInterpolatedValues, "r", ...
        bernsteinEvaluationInterval, notAKnotInterpolatedValues, "g", ...
        interpolationAscisseVector, functionValuesVector, "+");
    grid;
    print 'exercise419-bernsteinInterpolationPlotOutput.tex' '-dTex' '-S800, 600';
    
endfunction

endfunction

function [y] = bernsteinRealFunction(x)
    y = abs(x);
endfunction
