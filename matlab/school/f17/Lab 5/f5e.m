function [dx] = f5e(t,x)
    dx = [x(2);
        25*cos(4*t) - 10*x(1) - 6*x(2)];
end
