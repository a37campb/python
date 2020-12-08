function [U] = U6a_bndry( t, n,~)
    U = -Inf*ones(n,n);
    for j = 1:n
        for k = 1:n
            x = (j - 1)/(n - 1);
            y = (k - 1)/(n - 1);
        
            r = sqrt( (x - 0.5)^2 + (y - 0.5)^2 );
            
            if r < 0.1
                decay_surge = (200-70)/(0.1-0);
                c_surge = 200-decay_surge*(0.1);
                decay_rate = (200-70)/(0.1-1);
                C = 200-decay_rate*0.1;
                if t <= 0.1
                    U(j, k) = decay_surge*t + c_surge;
                else
                    U(j,k) = decay_rate*t + C;
                end
            elseif r >= (n - 1)/(2*n)
                if y <= 0.5
                    U(j, k) = 0;
                else
                    U(j, k) = NaN;
                end
            end
        end
    end
end

