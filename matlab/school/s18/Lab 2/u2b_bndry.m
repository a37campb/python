function [u] = u2b_bndry(t)
    u = [0*t + 1;
         (t<2).*(0*t + 0) + (t>=2).*(0*t + 3)];
end
