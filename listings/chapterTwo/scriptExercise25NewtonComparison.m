## scriptExercise25NewtonComparison
# script per lanciare l'esecuzione della comparazione del solo metodo di Newton usando 
# i due diversi criteri, relativamente all'esercizio 2.5

disp('application of the Newton method with increment stop criteria')
for cursor = 2:2:16
	disp(strcat('application with tolx = ', num2str(10^(-cursor))))
	[x, i] = newtonMethod('function25first','function25firstDerivative', 10, 1e5, 10^(-cursor), 10^(-cursor), 'incrementCriterion')
end
disp('')
disp('application of the second function')
for cursor = 2:2:16
	disp(strcat('application with tolx = ', num2str(10^(-cursor))))
	[x, i] = newtonMethod('function25second','function25secondDerivative', 10, 1e5, 10^(-cursor), 10^(-cursor), 'incrementCriterion')
end
disp('------------------------------------------------------------------------')

disp('application of the Newton method with residue stop criteria')
for cursor = 2:2:16
	disp(strcat('application with tolx = ', num2str(10^(-cursor))))
	[x, i] = newtonMethod('function25first','function25firstDerivative', 10, 1e5, 10^(-cursor), 10^(-cursor), 'residueCriterion')
end
disp('')
disp('application of the second function')
for cursor = 2:2:16
	disp(strcat('application with tolx = ', num2str(10^(-cursor))))
	[x, i] = newtonMethod('function25second','function25secondDerivative', 10, 1e5, 10^(-cursor), 10^(-cursor), 'residueCriterion')
end
disp('------------------------------------------------------------------------')