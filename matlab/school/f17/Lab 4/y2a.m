function [y] = y2a(t)
    y = (t.^3 - 3*t.^2 + 3*t)./(t.^3 - 3*t.^2 + 3*t + 3);
end