function [] = exercise411()

    # the factored code allow me to specify the function that produce the
    # array of interpolation ascisse
    [domain, rungeErrorVector, bernsteinErrorVector, ...
    rungeEvaluationIntervalOutput, rungeInterpolatedOrdinateVectorOutput,...
    bernsteinEvaluationIntervalOutput, bernsteinInterpolatedOrdinateVectorOutput] = ...
      exercises411415CommonFactor([1:1:50], "linspace");

    # plot the output values sent by the common code
    plot(rungeEvaluationIntervalOutput, ...
      rungeInterpolatedOrdinateVectorOutput, "b", ...
      bernsteinEvaluationIntervalOutput, ...
      bernsteinInterpolatedOrdinateVectorOutput, "r");
    grid;
    print "exercise411-currentApproximationPlotOutput.tex" '-dTex' '-S800, 600';

    # plot the errors
    semilogy(domain, rungeErrorVector, "b", ...
        domain, bernsteinErrorVector, "r");
    grid;
    print "exercise411-ErrorsSemilogYPlotOutput.tex" '-dTex' '-S800, 600';

    loglog(domain, rungeErrorVector, "b", ...
        domain, bernsteinErrorVector, "r");
    grid;
    print "exercise411-ErrorsLoglogPlotOutput.tex" '-dTex' '-S800, 600';

endfunction
