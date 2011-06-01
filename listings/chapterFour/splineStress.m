function [] = splineStress()

    intervalMagnitude = 5;
    # build the partition vector and its associated vector of interpolation conditions
    interpolationAscisseVector = linspace(-intervalMagnitude, intervalMagnitude, 12)';
    
    # the following lines allow to add points in which we want to study the 
    # non-regularity of the function
    interpolationAscisseVector = [interpolationAscisseVector; -1; 0; 1];
    interpolationAscisseVector = sort(interpolationAscisseVector);
    
    functionValuesVector = realFunction(interpolationAscisseVector, intervalMagnitude);

    # build the domain vectors containing the range where we want to interpolate
    # the real function.
    domain = linspace(-intervalMagnitude, intervalMagnitude, 200)';
    realFunctionValuesVector = realFunction(domain, intervalMagnitude);

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
    print 'splineStress-interpolationPlotOutput.tex' '-dTex' '-S800, 600';

    semilogy(domain, abs(realFunctionValuesVector - normalInterpolatedValues), "b", ...
        domain, abs(realFunctionValuesVector - notAKnotInterpolatedValues), "r");
    grid;
    print 'splineStress-errorsPlotOutput.tex' '-dTex' '-S800, 600';
    
    plot(domain, abs(realFunctionValuesVector - normalInterpolatedValues), "b", ...
        domain, abs(realFunctionValuesVector - notAKnotInterpolatedValues), "r");
    grid;
    print 'splineStress-linearErrorsPlotOutput.tex' '-dTex' '-S800, 600';


endfunction

# capture the real model of the function
function [value] = realFunction(ascissa, intervalMagnitude)
    value = zeros(length(ascissa),1);
    for i = 1:length(ascissa)
        if ascissa(i) < -1
            value(i) = (ascissa(i) + intervalMagnitude)*(ascissa(i) ...
                +1)*exp(ascissa(i));
        elseif ascissa(i) <= 1
            value(i) = sqrt(1 - ascissa(i)^(2));
        else
            value(i) = (ascissa(i) -1)*1/(ascissa(i)^2);
        end
    end
endfunction
