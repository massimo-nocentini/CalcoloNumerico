function [value] = secondDer517(ascissa)
  value = -24*ascissa^(-5)*cos(ascissa^(-2)) + ...
    36*ascissa^(-7)*sin(ascissa^(-2)) + ...
    8*ascissa^(-9)*cos(ascissa^(-2));
endfunction
