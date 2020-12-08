function [dw] = f5c( t, w )
    dw = [w(2);
         -w(2) - 3*w(1) + t - 1];
end

