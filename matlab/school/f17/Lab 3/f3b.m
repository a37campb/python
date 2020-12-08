function [dy] = f3b(t,y)
    dy = (-t*y)+y+t-cos(y);
end