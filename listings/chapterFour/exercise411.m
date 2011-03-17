function [] = exercise411()
    toInterpolateAscisseVector = linspace(-1, 1, 30)';

    interpolationOrdinateVector = toInterpolateAscisseVector;
    for i=1:length(toInterpolateAscisseVector)
        interpolationOrdinateVector(i) = realFunction(toInterpolateAscisseVector(i));
    end

    # linspace return a row vector, so I transpose in order to obtain a column 
    # vector
    interpolationAscisseVector1 = linspace(-1, 1, 15)';
    interpolatedFunctionValuesVector1 = exercise_Internal(...
        interpolationAscisseVector1, toInterpolateAscisseVector);

    # linspace return a row vector, so I transpose in order to obtain a column 
    # vector
    interpolationAscisseVector2 = linspace(-1, 1, 10)';
    interpolatedFunctionValuesVector2 = exercise_Internal(...
        interpolationAscisseVector2, toInterpolateAscisseVector);

    # linspace return a row vector, so I transpose in order to obtain a column 
    # vector
    interpolationAscisseVector3 = linspace(-1, 1, 5)';
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
    print 'exercise411-CorrectPlotOutput.tex' '-dTex' '-S800, 600';

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
    y = abs(x);
endfunction
