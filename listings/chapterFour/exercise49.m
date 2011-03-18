function [] = exercise49()

    # setup the vector with the ascisse where we want to evaluate
    toInterpolateAscisseVector = linspace(-0, 1, 101)';

    # initialize the two vectors for real function and first derivate values
    realFunctionValuesVector = toInterpolateAscisseVector;
    realFirstDerivateValuesVector = toInterpolateAscisseVector;

    # computes the effective values for real and first derivate function
    for i=1:length(toInterpolateAscisseVector)
        realFunctionValuesVector(i) = realFunction(toInterpolateAscisseVector(i));
        realFirstDerivateValuesVector(i) = realFunctionFirstDerivate(...
            toInterpolateAscisseVector(i));
    end

    # setup the vector with the interpolation ascisse, its function values and
    # first derivative values vectors
    interpolationAscisseVector = [0; 0.25; 0.5; 0.75; 1]; #linspace(0,1,5);
    interpolationOrdinateVector = interpolationAscisseVector;
    firstDerivateValuesVector = interpolationAscisseVector;

    for i=1:length(interpolationAscisseVector)
        interpolationOrdinateVector(i) = realFunction(interpolationAscisseVector(i));
        firstDerivateValuesVector(i) = realFunctionFirstDerivate(interpolationAscisseVector(i));
    end

    # Newton: differenze divise
    newtonDifferenzeDiviseVector = differenzeDiviseEngine(interpolationAscisseVector, ...
        interpolationOrdinateVector);

    # Hermite: differenze divise
    [doubledAscisseVector, hermiteDifferenzeDiviseVector] = hermiteDifferenzeDiviseEngine(...
        interpolationAscisseVector, interpolationOrdinateVector, firstDerivateValuesVector);

    # plot the differenze divise curve
    plot(interpolationAscisseVector, newtonDifferenzeDiviseVector, "b", ...
        doubledAscisseVector, hermiteDifferenzeDiviseVector, "r");
    grid;
    print 'exercise49-DifferenzeDivisePlotOutput.tex' '-dTex' '-S800, 600';
    
    # Newton: interpolation step.
    newtonToInterpolateOrdinateVector = HornerGeneralizzato(toInterpolateAscisseVector, ...
        interpolationAscisseVector, newtonDifferenzeDiviseVector);

    # Hermite: interpolation step.
    hermiteToInterpolateOrdinateVector = Hermite(toInterpolateAscisseVector, ...
        doubledAscisseVector, hermiteDifferenzeDiviseVector);

    plot(toInterpolateAscisseVector, realFunctionValuesVector, "g", ...
        toInterpolateAscisseVector, newtonToInterpolateOrdinateVector, "b", ...
        toInterpolateAscisseVector, hermiteToInterpolateOrdinateVector, "r");
    grid;
    print 'exercise49-normalPlotOutput.tex' '-dTex' '-S800, 600';

    plot(toInterpolateAscisseVector, abs(realFunctionValuesVector - ...
        newtonToInterpolateOrdinateVector), "b", ...
        toInterpolateAscisseVector, abs(realFunctionValuesVector - ...
        hermiteToInterpolateOrdinateVector), "r");
    grid;
    print 'exercise49-errorsPlotOutput.tex' '-dTex' '-S800, 600';

    semilogy(toInterpolateAscisseVector, abs(realFunctionValuesVector - ...
        newtonToInterpolateOrdinateVector), "b", ...
        toInterpolateAscisseVector, abs(realFunctionValuesVector - ...
        hermiteToInterpolateOrdinateVector), "r");
    grid;
    print 'exercise49-errorsSemilogYPlotOutput.tex' '-dTex' '-S800, 600';

    #semilogy(toInterpolateAscisseVector, realFunctionValuesVector, "b", ...
    #    toInterpolateAscisseVector, realFirstDerivateValuesVector, "r", ...
    #    toInterpolateAscisseVector, newtonToInterpolateOrdinateVector, "c", ...
    #    toInterpolateAscisseVector, hermiteToInterpolateOrdinateVector, "g");
    #grid;
    #print 'exercise49-semilogyPlotOutput.tex' '-dTex' '-S800, 600';

endfunction

function [y] = realFunction(x)
    y = (x-1)^(9);
endfunction

function [y] = realFunctionFirstDerivate(x)
    y = 9*(x-1)^(8);
endfunction
