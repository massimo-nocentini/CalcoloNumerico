function [ordinateVector] = HornerGeneralizzato(ascisseToEvaluateVector, ...
    ascisseVector, differenzeDiviseVector)

    # initialize the vector ordinateVector to be a vector of the same length
    # of ascisseToEvaluateVector vector
    ordinateVector = ascisseToEvaluateVector;
    for i=1:length(ascisseToEvaluateVector)
        ordinateVector(i) = internal_HornerGeneralizzato(...
            ascisseToEvaluateVector(i), ascisseVector, differenzeDiviseVector);
    end

end

function [y] = internal_HornerGeneralizzato(x, ...
    ascisseVector, differenzeDiviseVector)
    # Assert: n = length(differenzeDiviseVector) = length(ascisseVector)
    n = length(differenzeDiviseVector);
    y = differenzeDiviseVector(n);
    for k=n-1:-1:1
        y = y * (x - ascisseVector(k)) + differenzeDiviseVector(k);
    end
end
