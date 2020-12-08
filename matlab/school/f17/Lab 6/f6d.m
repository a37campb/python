function [dw] = f6d( x, w )
    dw = [w(2);
          exp(-x) - (x^2)*w(2) - (1-x^2)*w(1);
          w(4);
          0 - (x^2)*w(4) - (1-x^2)*w(3)];
end