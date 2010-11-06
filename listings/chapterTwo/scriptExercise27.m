# script per lanciare l'esecuzione dell'esercizio 2.7

disp('bisection method')
for cursor = 2:2:16
	disp(strcat('tol_x = ', num2str(10^(-cursor))));
	[x, i] = bisectionMethod('exercise27Function', 0, 1, 10^(-cursor))
end

disp('---------------------');

disp('Newton method')
for cursor = 2:2:16
	disp(strcat('tol_x = ', num2str(10^(-cursor))));
	[x, i] = newtonMethod('exercise27Function','exercise27FunctionDerivative', 0, 1e5, 10^(-cursor), 10^(-cursor), 'incrementCriterion')
end

disp('---------------------');

disp('chord method')
for cursor = 2:2:16
	disp(strcat('tol_x = ', num2str(10^(-cursor))));
	[x, i] = chordMethodLinearCriteria('exercise27Function','exercise27FunctionDerivative', 0, 1e5, 10^(-cursor), 10^(-cursor), 'residueCriterion')
end

disp('---------------------');

disp('secant method')
for cursor = 2:2:16
	disp(strcat('tol_x = ', num2str(10^(-cursor))));
	[x, i] = secantMethod('exercise27Function','exercise27FunctionDerivative', 0, 1e5, 10^(-cursor), 10^(-cursor))
end

disp('---------------------');
