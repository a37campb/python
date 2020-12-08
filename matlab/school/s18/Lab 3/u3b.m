function [u] = u3b(x,t)
    u = (4/pi)*sin(x)*exp(-t) + (4/(3*pi))*sin(3*x)*exp(-9*t) + (4/(5*pi))*sin(5*x)*exp(-25*t);
end