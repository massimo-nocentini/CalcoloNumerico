function [] = exercise49()
    toInterpolateAscisseVector = linspace(0, 1, 101)';
    interpolationAscisseVector = [0; 0.25; 0.5; 0.75; 1];
    interpolationOrdinateVector = interpolationAscisseVector;

    for i=1:length(interpolationAscisseVector)
        interpolationOrdinateVector(i) = realFunction(interpolationAscisseVector(i));
    end

    # Newton: differenze divise
    newtonDifferenzeDiviseVector = differenzeDiviseEngine(interpolationAscisseVector, ...
        interpolationOrdinateVector);

    # Hermite: differenze divise
    [doubledAscisseVector, hermiteDifferenzeDiviseVector] = hermiteDifferenzeDiviseEngine ...
        (interpolationAscisseVector, interpolationOrdinateVector);

    # plot the differenze divise curve
    plot(interpolationAscisseVector, newtonDifferenzeDiviseVector, "b", ...
        doubledAscisseVector, hermiteDifferenzeDiviseVector, "r");
    grid;
    print 'exercise49-DifferenzeDivisePlotOutput.tex' '-dTex' '-S800, 600';
    
    # Newton: interpolation step.
    newtonToInterpolateOrdinateVector = HornerGeneralizzato(toInterpolateAscisseVector, ...
        interpolationAscisseVector, newtonDifferenzeDiviseVector);

    # Hermite: interpolation step.
    hermiteToInterpolateOrdinateVector = HornerGeneralizzato(toInterpolateAscisseVector, ...
        doubledAscisseVector, hermiteDifferenzeDiviseVector);

    plot(interpolationAscisseVector, interpolationOrdinateVector, "b+", ...
        toInterpolateAscisseVector, newtonToInterpolateOrdinateVector, "c", ...
        doubledAscisseVector, hermiteDifferenzeDiviseVector, "g");
    grid;
    print 'exercise49-CorrectPlotOutput.tex' '-dTex' '-S800, 600';

endfunction

function [y] = realFunction(x)
    y = (x-1)^(9);
endfunction
