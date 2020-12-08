function[output] = D2c(u,x,h)
    %Given u is a function of x and h
    output = (u(x+h) - 2*u(x) + u(x-h))/(h^2);
end