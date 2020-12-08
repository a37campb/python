function [dy] = f4b(t, y)
    dy = -t.*y + y + t - cos(y);
end