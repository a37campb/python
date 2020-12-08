function [dw] = f6b( x, w )
    dw = [w(2);
          sin(x) - 4*w(2) - 7*x*w(1);
          w(4);
          0      - 4*w(4) - 7*x*w(3)];
end
