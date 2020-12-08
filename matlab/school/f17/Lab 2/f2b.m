function [y] = f2b(x)
    y = 4*x*exp(-2*x) - 4*(x^2)*exp(-x) + exp((-x)/2);
end