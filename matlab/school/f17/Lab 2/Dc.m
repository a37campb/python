function[output] = Dc(u,x,h)
    %Given u is a function of x and h
    output = (u(x+h) - u(x-h))/(2*h);
end