function [matrix] = triangularBidiagonalMatrixBuilder(...
    diagonalVector, bidiagonalVector, matrixType)

    # invoco la strategy che mi permette di costruire il tipo di matrice
    # che viene richiesto.
    matrix = feval(matrixType, diagonalVector, bidiagonalVector);

endfunction
    
function [matrix] = internal_LowerBidiagonalMatrix(diagonalVector, bidiagonalVector)
    # set the dimension refering to the "main" vector, ie. the diagonal vector.
    dimension = length(diagonalVector);

    # build the matrix, keeping the zero matrix as initial matrix value.
    matrix = zeros(dimension);

    for i = 1:dimension
        matrix(i, i) = diagonalVector(i);

        if i < dimension
            # for the upper type we set the bottom-adiacent item
            matrix(i+1, i) = bidiagonalVector(i);
        end
    end
endfunction

function [matrix] = internal_UpperBidiagonalMatrix(diagonalVector, bidiagonalVector)
    # set the dimension refering to the "main" vector, ie. the diagonal vector.
    dimension = length(diagonalVector);

    # build the matrix, keeping the zero matrix as initial matrix value.
    matrix = zeros(dimension);

    for i = 1:dimension
        matrix(i, i) = diagonalVector(i);

        if i < dimension
            # for the upper type we set the right-adiacent item
            matrix(i, i + 1) = bidiagonalVector(i);
        end
    end
endfunction
