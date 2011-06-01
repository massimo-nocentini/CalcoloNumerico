function [] = exercise411()

    [domain, rungeErrorVector, bernsteinErrorVector] = ...
      # the factored code allow me to specify the function that produce the
      # array of interpolation ascisse
      exercises411415CommonFactor([1:1:100], "linspace");

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
