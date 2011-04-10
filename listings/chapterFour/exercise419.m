function [] = exercise419()

    # build the partition vector and its associated vector of interpolation conditions
    interpolationAscisseVector = linspace(-30, 30, 30)';
    functionValuesVector = realFunction(interpolationAscisseVector);

    # build the domain vectors containing the range where we want to interpolate
    # the real function.
    domain = linspace(-30, 30, 500)';
    realFunctionValuesVector = realFunction(domain);

    # setting up the parameter to drive the cubic splain engine.
    splainSchemeMatrixToFactorStrategyName = 'normalSplainScheme_BuildMatrixToFactor';
    splainSchemeMisStrategyName = 'normalSplainScheme_BuildMisVector';

    # go!
    [hVector, varPhiVector, xiVector, lVector, uVector, lowerBiadiagonalMatrix, ...
        upperBiadiagonalMatrix, diffDiviseVector, mis, normalInterpolatedValues] = ...
        cubicSplainEngine(interpolationAscisseVector, functionValuesVector, ...
        splainSchemeMatrixToFactorStrategyName, splainSchemeMisStrategyName, domain);

    # setting up the parameter to drive the cubic splain engine.
    splainSchemeMatrixToFactorStrategyName = 'notAKnotSplainScheme_BuildMatrixToFactor';
    splainSchemeMisStrategyName = 'notAKnotSplainScheme_BuildMisVector';

    [hVector, varPhiVector, xiVector, lVector, uVector, lowerBiadiagonalMatrix, ...
        upperBiadiagonalMatrix, diffDiviseVector, mis, notAKnotInterpolatedValues] = ...
        cubicSplainEngine(interpolationAscisseVector, functionValuesVector, ...
        splainSchemeMatrixToFactorStrategyName, splainSchemeMisStrategyName, domain);

    plot(domain, realFunctionValuesVector, "b", ...
        domain, normalInterpolatedValues, "r", ...
        domain, notAKnotInterpolatedValues, "g", ...
        interpolationAscisseVector, functionValuesVector, "+");
    grid;
    print 'exercise419-interpolationPlotOutput.tex' '-dTex' '-S800, 600';

    semilogy(domain, abs(realFunctionValuesVector - normalInterpolatedValues), "b", ...
        domain, abs(realFunctionValuesVector - notAKnotInterpolatedValues), "r");
    grid;
    print 'exercise419-errorsPlotOutput.tex' '-dTex' '-S800, 600';


endfunction

# capture the real model of the function
function [value] = realFunction(ascissa)
    value = 0.85*sin(ascissa).*(ascissa.^(-2) + 2) + 9.07*cos(ascissa);
endfunction
