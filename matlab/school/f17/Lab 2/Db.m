function[output] = Db(u,x,h)
    %Given u is a function of x and h
    output = (3*u(x) - 4*u(x-h) + u(x-(2*h)))/(2*h);
end