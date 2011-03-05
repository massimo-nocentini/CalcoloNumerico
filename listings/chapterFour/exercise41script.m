# script for easy of exercise 4.1 testing
ascisse = -20:1:20;
[ascisse, interpolatedYs, realYs] = exercise41(ascisse);
plot(ascisse, realYs, "c", ascisse, interpolatedYs, "b+");
grid;
print 'exercise41PlotOutput.tex' '-dTex' '-S800, 600';
