function [] = exercise47()
    # linspace return a row vector, so I transpose in order to obtain a column 
    # vector
    interpolationAscisseVector = linspace(-3, 3,30)';
    interpolationOrdinateVector = interpolationAscisseVector;
    for i=1:length(interpolationAscisseVector)
        interpolationOrdinateVector(i) = realFunction(interpolationAscisseVector(i));
    end

    differenzeDiviseVector = differenzeDiviseEngine(interpolationAscisseVector, ...
        interpolationOrdinateVector);

    # plot the differenze divise curve
    plot(interpolationAscisseVector, differenzeDiviseVector, "b");
    grid;
    print 'exercise47-DifferenzeDivisePlotOutput.tex' '-dTex' '-S800, 600';

    toInterpolateAscisseVector = linspace(-2, 2,80)';
    toInterpolateOrdinateVector = HornerGeneralizzato(toInterpolateAscisseVector, ...
        interpolationAscisseVector, differenzeDiviseVector);

    plot(interpolationAscisseVector, interpolationOrdinateVector, "b+", ...
        toInterpolateAscisseVector, toInterpolateOrdinateVector, "c");
    grid;
    print 'exercise47-CorrectPlotOutput.tex' '-dTex' '-S800, 600';

    toInterpolateAscisseVector = linspace(-3.005, 3.005,130)';
    toInterpolateOrdinateVector = HornerGeneralizzato(toInterpolateAscisseVector, ...
        interpolationAscisseVector, differenzeDiviseVector);

    plot(interpolationAscisseVector, interpolationOrdinateVector, "b+", ...
        toInterpolateAscisseVector, toInterpolateOrdinateVector, "c");
    grid;
    print 'exercise47-InCorrectPlotOutput.tex' '-dTex' '-S800, 600';
endfunction

function [y] = realFunction(x)
    y = 1 / (1 + x^(2));
endfunction
