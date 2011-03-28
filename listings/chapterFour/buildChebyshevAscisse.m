function [chebyshevAscisse] = buildChebyshevAscisse(a, b, n)

    # use the (4.40) formula to build the following values
    length = n;
    chebyshevAscisse = ones(length, 1);
    for i = length:-1:1
        chebyshevAscisse(i) = cos((2*(i - 1) + 1)*pi / (2*(length+1)));

        chebyshevAscisse(i) = (a + b)/2 + ((b-a)/2)*chebyshevAscisse(i);
    end
endfunction
