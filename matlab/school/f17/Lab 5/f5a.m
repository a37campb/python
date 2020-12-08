function [dy] = f5a(t,y)
    %y is a column vector of length 2
    dy = [y(1)*(1-2*y(2))
        y(2) *(y(1) -1)];
end