function [dw] = f6a( x, w )
    dw = [w(2);
          1 - sin(x)*w(2) - w(1);
          w(4);
          0 - sin(x)*w(4) - w(3)];
end