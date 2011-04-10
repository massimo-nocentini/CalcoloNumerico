function [hVector, varPhiVector, xiVector, lVector, uVector, lowerBiadiagonalMatrix, ...
    upperBiadiagonalMatrix, diffDiviseVector, mis, interpolatedValues] = ...
        cubicSplainEngine(interpolationAscisseVector, functionValuesVector, ...
        splainSchemeMatrixToFactorStrategyName, splainSchemeMisStrategyName, domain)
    
    # build the vectors    
    [hVector, varPhiVector, xiVector] = ...
        hVarphiXiVectorsBuilder(interpolationAscisseVector);

    # build the matrix to factor, this costruction process depend on the parameter
    # splainSchemeMatrixToFactorStrategyName
    matrixToFactor = feval(splainSchemeMatrixToFactorStrategyName, varPhiVector, xiVector);

    # factor the matrix
    [lVector, uVector] = tridiagonaleLUFactor(matrixToFactor);

    # build the diagonal vector and build the lower trian. matrix
    lowerDiagonalVector = ones(length(lVector), 1);
    lowerBiadiagonalMatrix = triangularBidiagonalMatrixBuilder(...
        lowerDiagonalVector, lVector, 'internal_LowerBidiagonalMatrix');

    # build the upper trian. matrix
    upperBiadiagonalMatrix = triangularBidiagonalMatrixBuilder(...
        uVector, xiVector, 'internal_UpperBidiagonalMatrix');

    # build the differenze divise vector and solve the system
    diffDiviseVector = internal_BuildThreeDifferenzeDiviseVector(...
        interpolationAscisseVector, functionValuesVector);
    mis = triangularSystemSolver(upperBiadiagonalMatrix, ...
        triangularSystemSolver(lowerBiadiagonalMatrix, diffDiviseVector, ...
        "lowerSolveEngine"), "upperSolveEngine");

    # manage the results
    mis = feval(splainSchemeMisStrategyName, mis, diffDiviseVector);

    # initialization of the interpolated values vactor
    interpolatedValues = zeros(length(domain), 1);

    for i = 1:length(domain)
        for index = 2:length(interpolationAscisseVector)
            x = domain(i);
            if x >= interpolationAscisseVector(index-1) && ...
                x <= interpolationAscisseVector(index)
                
                ri = internal_RiComputer(index, mis, interpolationAscisseVector, ...
                    functionValuesVector, hVector);

                qi = internal_QiComputer(index, mis, interpolationAscisseVector, ...
                    functionValuesVector, hVector);

                interpolatedValues(i) = internal_Eval(x, index, ...
                    interpolationAscisseVector, mis, ri, qi, hVector(index-1));
                
                break;
            end
        end
    end

endfunction

function [diffDiviseVector] = internal_BuildThreeDifferenzeDiviseVector(...
    interpolationAscisseVector, functionValuesVector)
    
    # compute the dimension of the returning vector
    dimension = length(interpolationAscisseVector) - 2;

    # initialize the vector
    diffDiviseVector = zeros(dimension, 1);

    for i = 1:dimension
        diffDiviseVector(i) = ...
            (...
                internal_BuildDiffDivisaBetweenTwoAscisse(...
                    interpolationAscisseVector(i+2),...
                    functionValuesVector(i+2), ...
                    interpolationAscisseVector(i+1), ...
                    functionValuesVector(i+1)) - ...
                internal_BuildDiffDivisaBetweenTwoAscisse(...
                    interpolationAscisseVector(i+1),...
                    functionValuesVector(i+1), ...
                    interpolationAscisseVector(i+0), ...
                    functionValuesVector(i+0)) ...   
            ) / ...
            (interpolationAscisseVector(i+2) - interpolationAscisseVector(i+0));
    end

endfunction

function [value] = internal_BuildDiffDivisaBetweenTwoAscisse(xi, fi, xi_1, fi_1)
    value = (fi - fi_1) / (xi - xi_1);
end

function [matrix] = normalSplainScheme_BuildMatrixToFactor(...
    varPhiVector, xiVector)
    
    dimension = length(varPhiVector) + 1;
    matrix = zeros(dimension);

    for i = 1:dimension # or length(xiVector) is the same
        matrix(i, i) = 2;

        # the following check is necessary to protect the access on the position
        # i on the two vectors xiVector and varPhiVector.
        if(i < dimension)
            matrix(i, i+1) = xiVector(i);
            matrix(i+1, i) = varPhiVector(i);
        end
    end

endfunction

function [mis] = normalSplainScheme_BuildMisVector(vector, diffDivise)

    # We have to add two conditions to the n-1 already present
    mis = zeros(length(vector) + 2, 1);

    for i = 1:length(vector)
        mis(i+1) = vector(i);
    end

endfunction

function [matrix] = notAKnotSplainScheme_BuildMatrixToFactor(...
    varPhiVector, xiVector)
    
    dimension = length(varPhiVector) + 1;
    matrix = zeros(dimension);

    for i = 2:(dimension-1) # or length(xiVector) is the same
        matrix(i, i) = varPhiVector(i);

        # the following check is necessary to protect the access on the position
        # i on the two vectors xiVector and varPhiVector.
        if(i < dimension -1)
            matrix(i, i+1) = 2;
            matrix(i, i+2) = xiVector(i);
        end
    end

    # setting the first row
    matrix(1,1) = varPhiVector(1);
    matrix(1,2) = 2 - varPhiVector(1);
    matrix(1,3) = xiVector(1) - varPhiVector(1);

    # setting the last row
    matrix(dimension, dimension - 2)  = varPhiVector(length(varPhiVector)) - ...
        xiVector(length(xiVector));
    matrix(dimension, dimension - 1)  = 2 - xiVector(length(xiVector));
    matrix(dimension, dimension) = xiVector(length(xiVector));

endfunction

function [mis] = notAKnotSplainScheme_BuildMisVector(vector, diffDivise)

    # We have to add two conditions to the n-1 already present
    mis = zeros(length(vector) + 2, 1);

    for i = 1:length(vector)
        mis(i+1) = vector(i);
    end

    # now we have to set the first and the last element
    mis(1) = diffDivise(1) - mis(2) - mis(3);
    mis(length(mis)) = diffDivise(length(diffDivise)) - ...
        mis(length(mis)-1) - mis(length(mis)-2);
endfunction

function [value] = internal_RiComputer(index, mis, interpolationAscisseVector, ...
    functionValuesVector, hVector)

    value = functionValuesVector(index-1) - ((hVector(index-1)^(2))/6)*mis(index-1);
endfunction

function [value] = internal_QiComputer(index, mis, interpolationAscisseVector, ...
    functionValuesVector, hVector)

    value = ((functionValuesVector(index) - functionValuesVector(index-1))/hVector(index-1))...
        - (hVector(index-1)/6)*(mis(index) - mis(index-1));
endfunction

function [value] = internal_Eval(ascissa, index, ...
    interpolationAscisseVector, mis, ri, qi, hi)

    a = (ascissa - interpolationAscisseVector(index -1))^(3);
    b = (interpolationAscisseVector(index) - ascissa)^(3);
    c = (a * mis(index)) + (b * mis(index-1));
    d = c / (6*hi);
    e = ascissa - interpolationAscisseVector(index-1);
    value = d + (e * qi) + ri;
endfunction

%da finire:
%- fare le implementazioni per lo schema 'not-a-knot'
