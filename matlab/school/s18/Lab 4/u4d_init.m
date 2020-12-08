function [u] = u4d_init(x)
    u = (0<=x & x<=1).*(x) + (1<x & x<=4).*((-1/3)*x + 4/3);
end