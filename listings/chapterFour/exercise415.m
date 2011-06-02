function [chebyshevAscisse] = exercise415()

    # the factored code allow me to specify the function that produce the
    # array of interpolation ascisse
    [domain, rungeErrorVector, bernsteinErrorVector, ...
    rungeEvaluationIntervalOutput, rungeInterpolatedOrdinateVectorOutput,...
    bernsteinEvaluationIntervalOutput, bernsteinInterpolatedOrdinateVectorOutput] = ...
      exercises411415CommonFactor([2:2:50], "buildChebyshevAscisse");
    
    # plot the output values sent by the common code
    plot(rungeEvaluationIntervalOutput, ...
      rungeInterpolatedOrdinateVectorOutput, "b", ...
      bernsteinEvaluationIntervalOutput, ...
      bernsteinInterpolatedOrdinateVectorOutput, "r");
    grid;
    print "exercise415-currentApproximationPlotOutput.tex" '-dTex' '-S800, 600';
    
    # plot the errors
    semilogy(domain, rungeErrorVector, "b", ...
        domain, bernsteinErrorVector, "r");
    grid;
    print "exercise415-ErrorsSemilogYPlotOutput.tex" '-dTex' '-S800, 600';

    loglog(domain, rungeErrorVector, "b", ...
        domain, bernsteinErrorVector, "r");
    grid;
    print "exercise415-ErrorsLoglogPlotOutput.tex" '-dTex' '-S800, 600';

endfunction
