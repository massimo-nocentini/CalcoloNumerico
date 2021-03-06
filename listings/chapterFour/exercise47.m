function [] = exercise47()
    toInterpolateAscisseVector = linspace(-4.5, 4.5,80)';

    interpolationOrdinateVector = toInterpolateAscisseVector;
    for i=1:length(toInterpolateAscisseVector)
        interpolationOrdinateVector(i) = realFunction(toInterpolateAscisseVector(i));
    end

    # linspace return a row vector, so I transpose in order to obtain a column 
    # vector
    interpolationAscisseVector1 = -5:0.5:5;
    interpolatedFunctionValuesVector1 = exercise_Internal(...
        interpolationAscisseVector1, toInterpolateAscisseVector);

    # linspace return a row vector, so I transpose in order to obtain a column 
    # vector
    interpolationAscisseVector2 = -5:1:5;
    interpolatedFunctionValuesVector2 = exercise_Internal(...
        interpolationAscisseVector2, toInterpolateAscisseVector);

    # linspace return a row vector, so I transpose in order to obtain a column 
    # vector
    interpolationAscisseVector3 = -5:2:5;
    interpolatedFunctionValuesVector3 = exercise_Internal(...
        interpolationAscisseVector3, toInterpolateAscisseVector);

    # initialing the real function value
    #errorVector = toInterpolateAscisseVector;
    #for i=1:length(toInterpolateAscisseVector)
    #    errorVector = realFunction(toInterpolateAscisseVector(i)) ...
    #        - toInterpolateOrdinateVector(i);
    #end

    #scale = 1:1:length(interpolationAscisseVector);
    #semilogy(scale, errorVector, "b");
    #grid;
    #print 'exercise47-ErrorPlotOutput.tex' '-dTex' '-S800, 600';    

    plot(toInterpolateAscisseVector, interpolationOrdinateVector, "b", ...
        toInterpolateAscisseVector, interpolatedFunctionValuesVector1, "c", ...
         toInterpolateAscisseVector, interpolatedFunctionValuesVector2, "g", ...
           toInterpolateAscisseVector, interpolatedFunctionValuesVector3, "r");
    grid;
    print 'exercise47-CorrectPlotOutput.tex' '-dTex' '-S800, 600';

endfunction

function [interpolatedFunctionValuesVector] = exercise_Internal(...
    interpolationAscisseVector, toInterpolateAscisseVector)

    interpolationOrdinateVector = interpolationAscisseVector;
    for i=1:length(interpolationAscisseVector)
        interpolationOrdinateVector(i) = realFunction(interpolationAscisseVector(i));
    end

    differenzeDiviseVector = differenzeDiviseEngine(interpolationAscisseVector, ...
        interpolationOrdinateVector);

    interpolatedFunctionValuesVector = HornerGeneralizzato(toInterpolateAscisseVector, ...
        interpolationAscisseVector, differenzeDiviseVector);
endfunction

function [y] = realFunction(x)
    y = 1 / (1 + x^(2));
endfunction
