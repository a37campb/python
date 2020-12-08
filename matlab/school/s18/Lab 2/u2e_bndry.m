function [u] = u2e_bndry(t)
    u = [0*t + cos(t);
        0*t + sin(t)];
end