function [dw] = f6f( x, w )
    dw = [w(2);
          sin(x) - w(1)*w(2) + (w(1))^2];
end