function [u] = u2c_bndry(t)
    u = [0*t + cosh(t);
        0*t + sinh(t)];
end