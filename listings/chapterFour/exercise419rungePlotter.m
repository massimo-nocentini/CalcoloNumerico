function [] = exercise419rungePlotter()

    evaluateSetDimension = 10^(4);

    [rungeEvaluationInterval, rungeEvaluatedFunctionValuesVector,...
    rungeInterpolationAscisseVector, rungeFunctionValuesVector,...
    rungeNormalInterpolatedValues, rungeNotAKnotInterpolatedValues] = ...
        exercise419runge(evaluateSetDimension, 10);

    plot(rungeEvaluationInterval, rungeEvaluatedFunctionValuesVector, "b", ...
        rungeEvaluationInterval, rungeNormalInterpolatedValues, "r", ...
        rungeEvaluationInterval, rungeNotAKnotInterpolatedValues, "g", ...
        rungeInterpolationAscisseVector, rungeFunctionValuesVector, "+");
    grid;
    print 'exercise419-rungeInterpolationPlotOutput.tex' '-dTex' '-S800, 600';
endfunction


