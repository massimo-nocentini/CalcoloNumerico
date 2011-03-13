function [differenzeDiviseVector] = differenzeDiviseEngine(ascisseVector, functionValuesVector)
    differenzeDiviseVector = functionValuesVector;
    n = length(functionValuesVector) - 1;
    for i=1:n
        for j=n+1:-1:i+1
            differenzeDiviseVector(j) = (differenzeDiviseVector(j) - ...
                differenzeDiviseVector(j-1)) / (ascisseVector(j) - ...
                ascisseVector(j-i));
        end
    end
endfunction
