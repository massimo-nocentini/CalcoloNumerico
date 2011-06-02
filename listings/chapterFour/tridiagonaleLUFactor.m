function [lVector, uVector] = tridiagonaleLUFactor(matrix)

    # find the dimension of the matrix to build the two vector l and u
    dimension = rows(matrix);

    # build the returning vectors
    uVector = zeros(dimension, 1);
    lVector = zeros(dimension, 1);

    # initializing the firsts' elements
    uVector(1) = 2;
    lVector(1) = 0; # Does this assignment is right?

    for i=2:dimension
        lVector(i) = matrix(i, i-1) / uVector(i-1);
        uVector(i) = 2- (matrix(i-1, i) * lVector(i));
    end

endfunction
