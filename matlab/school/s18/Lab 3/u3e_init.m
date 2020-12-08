function [u] = u3e_init(x)
    u = (4/(x+1))*sinh(x) + (4/(3*x + 1))*sin(3*x) + (4/(5*x + 1))*sin(5*x);
end