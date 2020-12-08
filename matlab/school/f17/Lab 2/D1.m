function[output] = D1(u,x,h)
    %Given u is a function of x and h
    output = (u(x+h) - u(x))/h;
end