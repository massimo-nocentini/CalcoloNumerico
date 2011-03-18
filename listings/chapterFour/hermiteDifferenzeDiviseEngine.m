function [doubledAscisseVector, differenzeDiviseVector] = ...
    hermiteDifferenzeDiviseEngine(ascisseVector, ...
        functionValuesVector, firstDerivateValuesVector)
    
    # build two column vector, doubling the dimension of the original ones,
    # passed as parameters.
    doubledAscisseVector = ones(length(ascisseVector)*2, 1);
    doubledFunctionValuesVector = ones(length(functionValuesVector)*2, 1);

    # setting up the vectors, doubling information and setting the first derivate
    # values when needed
    for i = 1:length(functionValuesVector)
        doubledAscisseVector(2*(i-1)+1) = ascisseVector(i);
        doubledAscisseVector(2*(i-1)+2) = ascisseVector(i);

        doubledFunctionValuesVector(2*(i-1)+1) = functionValuesVector(i);
        doubledFunctionValuesVector(2*(i-1)+2) = firstDerivateValuesVector(i);
    end

    differenzeDiviseVector = hermiteDifferenzeDiviseEngineInternal(...
        doubledAscisseVector, doubledFunctionValuesVector);
endfunction

function [differenzeDiviseVector] = hermiteDifferenzeDiviseEngineInternal ...
    (ascisseVector, functionValuesVector)
    
    # Assume that in ascisseVector thare are a duplicate foreach original ascissa
    n = length(ascisseVector) - 1;

    # setup the differenzeDiviseVector vector
    differenzeDiviseVector = functionValuesVector;

    # build the derivative of function f on odd positions
    for i=n:-2:3
        differenzeDiviseVector(i) = (differenzeDiviseVector(i) - differenzeDiviseVector(i-2)) ...
         / (ascisseVector(i) - ascisseVector(i-2));
    end

    for i=2:n
        for j=n+1:-1:i+1
            differenzeDiviseVector(j) = (differenzeDiviseVector(j) - ...
                differenzeDiviseVector(j-1)) / (ascisseVector(j) - ...
                ascisseVector(j-i));
        end
    end
endfunction
