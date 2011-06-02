function [hVector, varPhiVector, xiVector] = ...
    hVarphiXiVectorsBuilder(interpolationAscisseVector)

    #interpolationAscisseVector
#    interpolationAscisseVector_length = length(interpolationAscisseVector)
    

    # compute the dimension of the new vectors to be built
    dimension = length(interpolationAscisseVector) - 1;

    # initialization of the column-vector h
    hVector = zeros(dimension, 1);

    # setting a dimension of minus one respect to hVector because at every step
    # we use two elements of hVector.
    varPhiXiDimension = dimension -1;
    varPhiVector = zeros(varPhiXiDimension, 1);
    xiVector = zeros(varPhiXiDimension, 1);

    # setting the hVector vector
    for i = 1:dimension
        hVector(i) = interpolationAscisseVector(i+1) - interpolationAscisseVector(i);
    end

    #hVector

    # setting the varPhiVector and xiVector vectors
    for i = 1:varPhiXiDimension
        varPhiVector(i) = hVector(i) / (hVector(i) + hVector(i+1));
        xiVector(i) = hVector(i+1) / (hVector(i) + hVector(i+1));
    end
    
    #varPhiVector + xiVector
    #length(varPhiVector + xiVector)
    
    #error('check the ascisse')

endfunction
