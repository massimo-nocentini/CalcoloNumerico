function [ordinateVector] = Hermite(ascisseToEvaluateVector, ...
    ascisseVector, differenzeDiviseVector)

    # initialize the vector ordinateVector to be a vector of the same length
    # of ascisseToEvaluateVector vector
    ordinateVector = ascisseToEvaluateVector;
    for i=1:length(ascisseToEvaluateVector)
        ordinateVector(i) = internal_Hermite(...
            ascisseToEvaluateVector(i), ascisseVector, differenzeDiviseVector);
    end

end

function [y] = internal_Hermite(x, ...
    ascisseVector, differenzeDiviseVector)
    # Assert: n = length(differenzeDiviseVector) = length(ascisseVector)
    n = length(differenzeDiviseVector);
    y = 0;
    polynomion = 1;

    for i=1:n
        y = y + differenzeDiviseVector(i)*polynomion;
        polynomion = polynomion * (x - ascisseVector(i));
    end
end
