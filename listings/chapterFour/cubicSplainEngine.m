function [hVector, varPhiVector, xiVector, lVector, uVector, lowerBiadiagonalMatrix, ...
    upperBiadiagonalMatrix, diffDiviseVector, mis, interpolatedValues] = ...
      cubicSplainEngine(interpolationAscisseVector, functionValuesVector, ...
        splainSchemeMatrixToFactorStrategyName, splainSchemeMisStrategyName, ...
        diffDiviseStrategyName, domain)
    
    # build the vectors
    [hVector, varPhiVector, xiVector] = ...
        hVarphiXiVectorsBuilder(interpolationAscisseVector);

    # build the matrix to factor, this costruction process depend on the parameter
    # splainSchemeMatrixToFactorStrategyName
    matrixToFactor = feval(splainSchemeMatrixToFactorStrategyName, varPhiVector, xiVector);

    # factor the matrix - works only with natural scheme
    #[lVector, uVector] = tridiagonaleLUFactor(matrixToFactor);

    # build the diagonal vector and build the lower trian. matrix
    #lowerDiagonalVector = ones(length(lVector), 1);
    #lowerBiadiagonalMatrix = triangularBidiagonalMatrixBuilder(...
    #    lowerDiagonalVector, lVector, 'internal_LowerBidiagonalMatrix');

    # build the upper trian. matrix - check passed
    #upperBiadiagonalMatrix = triangularBidiagonalMatrixBuilder(...
    #    uVector, xiVector, 'internal_UpperBidiagonalMatrix');

    # build the differenze divise vector and solve the system
    # invoking polymorphically the strategy to build the differenze divise vector
    diffDiviseVector = feval(diffDiviseStrategyName, ...
        interpolationAscisseVector, functionValuesVector);
        
    # factor LU - todo: use a more efficient factorization like above
    [L, U, p, unknowns] = PALUmethod (matrixToFactor, diffDiviseVector);
        
    # solve the system and find the mis
    mis = triangularSystemSolver(U, ...
        triangularSystemSolver(L, diffDiviseVector, ...
        "lowerSolveEngine"), "upperSolveEngine");

    # manage the results, adjusting the mis vector
    mis = feval(splainSchemeMisStrategyName, mis, diffDiviseVector);

    # initialization of the interpolated values vactor
    interpolatedValues = zeros(length(domain), 1);

    # caching the values of qi and ri, initialized with a dummy row
    chaceMatrix = [-1 -1];
    for index = 2:length(interpolationAscisseVector)
            
      ri = internal_RiComputer(index, mis, interpolationAscisseVector, ...
          functionValuesVector, hVector);

      qi = internal_QiComputer(index, mis, interpolationAscisseVector, ...
          functionValuesVector, hVector);

      chaceMatrix = [chaceMatrix; ri qi];            
    end
    
    # cleaning up the first dummy row
    chaceMatrix = chaceMatrix(2:rows(chaceMatrix), :);
    
    for i = 1:length(domain)
        for index = 2:length(interpolationAscisseVector)
            x = domain(i);
            if x >= interpolationAscisseVector(index-1) && ...
                x <= interpolationAscisseVector(index)
                
                ri = chaceMatrix(index-1, 1);

                qi = chaceMatrix(index-1, 2);

                interpolatedValues(i) = internal_Eval(x, index, ...
                    interpolationAscisseVector, mis, ri, qi, hVector(index-1));
                
                break;
            end
        end
    end

endfunction

function [diffDiviseVector] = internal_naturalBuildThreeDifferenzeDiviseVector(...
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
    diffDiviseVector = 6*diffDiviseVector;

endfunction

function [diffDiviseVector] = internal_notAKnotBuildThreeDifferenzeDiviseVector(...
    interpolationAscisseVector, functionValuesVector)
    
    [diffDiviseVector] = internal_naturalBuildThreeDifferenzeDiviseVector(...
      interpolationAscisseVector, functionValuesVector);
      
    # adjusting the vector according to linear system on page 99
    diffDiviseVector = [0; diffDiviseVector; 0];
      
endfunction

function [value] = internal_BuildDiffDivisaBetweenTwoAscisse(xi, fi, xi_1, fi_1)
    value = (fi - fi_1) / (xi - xi_1);
end

function [matrix] = normalSplainScheme_BuildMatrixToFactor(...
    varPhiVector, xiVector)
    
    dimension = length(varPhiVector);
    matrix = zeros(dimension);

    for i = 1:dimension
        
        # on the left (column) of the diagonal item
        if (i-1) > 0
          matrix(i, i-1) = varPhiVector(i);
        end

        # diagonal item, always fixed to 2    
        matrix(i, i) = 2;

        # on the right (column) of the diagonal item
        if (i+1) < (dimension + 1)
          matrix(i, i+1) = xiVector(i);
        end

    end
    
endfunction

function [mis] = normalSplainScheme_BuildMisVector(vector, diffDivise)

    # We have to add two conditions to the n-1 already present
    mis = zeros(length(vector) + 2, 1);

    for i = 2:(length(mis)-1)
        mis(i) = vector(i-1);
    end
    
endfunction

function [matrix] = notAKnotSplainScheme_BuildMatrixToFactor(...
    varPhiVector, xiVector)
    
    dimension = length(varPhiVector) + 2;
    matrix = zeros(dimension);

    # now we complete the setup according to (4.59) of textbook
    # setting the first row
    matrix(1,1) = xiVector(1);
    matrix(1,2) = -1;
    matrix(1,3) = varPhiVector(1);

    # we stop at dimension-2 for allow a post completion of the matrix on the
    # last two rows, starting from the third row, because the first two rows
    # are managed outside the loop
    for i = 2:(dimension - 1)
        # inside this loop we are free to check the index boundaries
        # because we are modifying a submatrix that doesn't share both the first
        # row and the first column.
        
        # on the left (column) of the diagonal item
        matrix(i, i-1) = varPhiVector(i-1);
        
        # diagonal item, always fixed to 2    
        matrix(i, i) = 2;

        # on the right (column) of the diagonal item
        matrix(i, i+1) = xiVector(i-1);
        
    end

    varXiVectorLength = length(varPhiVector);

    # setting the last row
    matrix(dimension, dimension - 2) = xiVector(varXiVectorLength);
    matrix(dimension, dimension - 1) = -1;
    matrix(dimension, dimension) = varPhiVector(varXiVectorLength);
    
endfunction

function [mis] = notAKnotSplainScheme_BuildMisVector(vector, diffDivise)

    # nothign to adjust here, the vector that resolve the system is already okey.
    mis = vector;
    
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
