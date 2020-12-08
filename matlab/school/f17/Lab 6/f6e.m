function [dw] = f6e( x, w )
    dw = [w(2);
          1 - w(1);
          w(4);
          0 - w(3)];
end