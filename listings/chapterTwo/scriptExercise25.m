# script per lanciare l'esecuzione dell'esercizio 2.5

disp('application of the Newton method')
for cursor = 2:2:16
	disp(strcat('application with tolx = ', num2str(10^(-cursor))))
	[x, i] = newtonMethod('function25first','function25firstDerivative', 10, 1e5, 10^(-cursor), 10^(-cursor), 10)
end
disp('')
disp('application of the second function')
for cursor = 2:2:16
	disp(strcat('application with tolx = ', num2str(10^(-cursor))))
	[x, i] = newtonMethod('function25second','function25secondDerivative', 10, 1e5, 10^(-cursor), 10^(-cursor), 10)
end
disp('------------------------------------------------------------------------')

disp('application of the Newton method with multiplicity m')
for cursor = 2:2:16
	disp(strcat('application with tolx = ', num2str(10^(-cursor))))
	[x, i] = newtonMethodMoltKnown('function25first','function25firstDerivative', 10, 1e5, 10^(-cursor), 10^(-cursor), 10)
end
disp('')
disp('application of the second function')
for cursor = 2:2:16
	disp(strcat('application with tolx = ', num2str(10^(-cursor))))
	[x, i] = newtonMethodMoltKnown('function25second','function25secondDerivative', 10, 1e5, 10^(-cursor), 10^(-cursor), 10)
end
disp('------------------------------------------------------------------------')

# disp('application of the Newton method with multiplicity m, linear stop criteria')
#for cursor = 2:2:16
#	disp(strcat('application with tolx = ', num2str(10^(-cursor))))
#	[x, i] = newtonMethodMoltKnownLinearCriteria('function25first','function25firstDerivative', 10, 1e5, 10^(-cursor), 10^(-cursor), 10)
#end
#disp('')
#disp('application of the second function')
#for cursor = 2:2:16
#	disp(strcat('application with tolx = ', num2str(10^(-cursor))))
#	[x, i] = newtonMethodMoltKnownLinearCriteria('function25second','function25secondDerivative', 10, 1e5, 10^(-cursor), 10^(-cursor), 10)
#end
#disp('------------------------------------------------------------------------')

disp('application of the Newton method Aitken version')
for cursor = 2:2:16
	disp(strcat('application with tolx = ', num2str(10^(-cursor))))
	[x, i] = newtonMethodAitken('function25first','function25firstDerivative', 10, 1e5, 10^(-cursor), 10^(-cursor), 10)
end
disp('')
disp('application of the second function')
for cursor = 2:2:16
	disp(strcat('application with tolx = ', num2str(10^(-cursor))))
	[x, i] = newtonMethodAitken('function25second','function25secondDerivative', 10, 1e5, 10^(-cursor), 10^(-cursor), 10)
end
disp('------------------------------------------------------------------------')