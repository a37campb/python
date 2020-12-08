function [dy] = f3a(t,y)
    dy =  (y - 1).^2 .* (t-1).^2;
end