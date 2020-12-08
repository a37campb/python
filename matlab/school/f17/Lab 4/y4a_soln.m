function [y] = y4a_soln( t )
    y = (t.^3 - 3*t.^2 + 3*t)./(t.^3 - 3*t.^2 + 3*t + 3);
end