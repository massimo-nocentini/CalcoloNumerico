function [hVector, varPhiVector, xiVector, lVector, uVector, lowerBiadiagonalMatrix, ...
    upperBiadiagonalMatrix, diffDiviseVector, mis, interpolatedValues] = ...
        cubicSplainEngine(interpolationAscisseVector, functionValuesVector, ...
        splainScheme, splainSchemeMisStrategyName, domain)
    
    # build the vectors    
    [hVector, varPhiVector, xiVector] = ...
        hVarphiXiVectorsBuilder(interpolationAscisseVector);

    # build the matrix to factor, this costruction process depend on the parameter
    # splainScheme
    matrixToFactor = feval(splainScheme, varPhiVector, xiVector);

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
    mis = feval(splainSchemeMisStrategyName, mis);

    # initialization of the interpolated values vactor
    interpolatedValues = zeros(length(domain), 1);

    for i = 1:length(domain)
        for index = 2:length(interpolationAscisseVector)
            if x >= interpolationAscisseVector(index-1) and ...
                x <= interpolationAscisseVector(index)
                
                ri = internal_RiComputer(index, mis, interpolationAscisseVector, ...
                    functionValuesVector, hVector);

                qi = internal_QiComputer(index, mis, interpolationAscisseVector, ...
                    functionValuesVector, hVector)

                interpolatedValues(i) = internal_Eval(domain(i), index, ...
                    interpolationAscisseVector, mis, ri, qi, hVector(index-1));
                     
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

function [mis] = normalSplainScheme_BuildMisVector(vector)

    # We have to add two conditions to the n-1 already present
    mis = zeros(length(vector) + 2, 1);

    for i = 1:length(vector)
        mis(i+1) = vector(i);
    end

endfunction

function [value] = internal_RiComputer(index, mis, interpolationAscisseVector, ...
    functionValuesVector, hVector)

    value = functionValuesVector(index-1) - ((hVector(i)^(2))/6)*mis(index-1);
endfunction

function [value] = internal_QiComputer(index, mis, interpolationAscisseVector, ...
    functionValuesVector, hVector)

    value = ((functionValuesVector(index) - functionValuesVector(index-1))/hVector(index))...
        - (hVector(i)/6)*(mis(index) - mis(index-1));
endfunction

function [value] = internal_Eval(ascissa, index, ...
    interpolationAscisseVector, mis, ri, qi, hi)

    value = ((...
                (mis(index)*((ascissa - interpolationAscisseVector(index -1))^(3))) + ...
                (mis(index-1)*((interpolationAscisseVector(index) - ascissa)^(3))))/(6*hi^(2))) + ...
                ((ascissa - interpolationAscisseVector(index-1))*qi) + ri;
endfunction

da finire:
- cambiare il nome al parametro 'splainScheme' per dare una semantica piu' parlante per la 
    costruzione della matrice da fattorizzare LU.
- fare le implementazioni per lo schema 'not-a-knot'
- aggiungere i parametri e i valori di ritorno alle attuali invocazioni e costruire
    uno script che permette di invocare in modo automatico le due modalita' e ne esegue il
    collect di tutti i risultati.
