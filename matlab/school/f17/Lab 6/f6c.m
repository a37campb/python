function [dw] = f6c( x, w )
    dw = [w(2);
          sin(x) - 4*w(2)*w(1) + 2*x*w(1)^2];
end
