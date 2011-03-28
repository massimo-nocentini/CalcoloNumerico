function [chebyshevAscisse] = exercise415()

    [domain, rungeErrorVector, bernsteinErrorVector] = exercises411415CommonFactor(...
        [2:2:100], "buildChebyshevAscisse");
    
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
