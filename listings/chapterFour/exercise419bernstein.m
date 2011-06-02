function [bernsteinEvaluationInterval, bernsteinEvaluatedFunctionValuesVector,...
    bernsteinInterpolationAscisseVector, bernsteinFunctionValuesVector,...
    bernsteinNormalInterpolatedValues, bernsteinNotAKnotInterpolatedValues] =...
    exercise419bernstein(evaluateSetDimension, numberOfAscisse)

    # build the vectors for valuate the interpolation and study the error.
    
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
    bernsteinInterpolationAscisseVector = linspace(-bernsteinIntervalMagnitude,...
        bernsteinIntervalMagnitude, numberOfAscisse)';
    for i=1:length(bernsteinInterpolationAscisseVector)
        bernsteinFunctionValuesVector(i) = bernsteinRealFunction(...
            bernsteinInterpolationAscisseVector(i));
    end    

    # setting up the parameter to drive the cubic splain engine.
    splainSchemeMatrixToFactorStrategyName = 'normalSplainScheme_BuildMatrixToFactor';
    splainSchemeMisStrategyName = 'normalSplainScheme_BuildMisVector';
    diffDiviseStrategyName = 'internal_naturalBuildThreeDifferenzeDiviseVector';

    # go!
    [hVector, varPhiVector, xiVector, lVector, uVector, lowerBiadiagonalMatrix, ...
        upperBiadiagonalMatrix, diffDiviseVector, mis, bernsteinNormalInterpolatedValues] = ...
        cubicSplainEngine(bernsteinInterpolationAscisseVector, bernsteinFunctionValuesVector, ...
        splainSchemeMatrixToFactorStrategyName, splainSchemeMisStrategyName,...
        diffDiviseStrategyName, bernsteinEvaluationInterval);

    # setting up the parameter to drive the cubic splain engine.
    splainSchemeMatrixToFactorStrategyName = 'notAKnotSplainScheme_BuildMatrixToFactor';
    splainSchemeMisStrategyName = 'notAKnotSplainScheme_BuildMisVector';
    diffDiviseStrategyName = 'internal_notAKnotBuildThreeDifferenzeDiviseVector';

    [hVector, varPhiVector, xiVector, lVector, uVector, lowerBiadiagonalMatrix, ...
        upperBiadiagonalMatrix, diffDiviseVector, mis, bernsteinNotAKnotInterpolatedValues] = ...
        cubicSplainEngine(bernsteinInterpolationAscisseVector, bernsteinFunctionValuesVector, ...
        splainSchemeMatrixToFactorStrategyName, splainSchemeMisStrategyName,...
        diffDiviseStrategyName, bernsteinEvaluationInterval);
    
endfunction

endfunction

function [y] = bernsteinRealFunction(x)
    y = abs(x);
endfunction
