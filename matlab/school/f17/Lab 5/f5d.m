function [dw] = f5d( t, w )
    L = 2;          % 2 H
    R = 1;          % 1 ohm
    C = 1/3;        % 0.333 F
    V_in = 1;
    dw = [w(2);
          V_in*(t<5)/L - R/L*w(2) - 1/C/L*w(1)];
end

