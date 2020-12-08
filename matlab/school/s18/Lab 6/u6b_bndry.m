function [U] = u6b_bndry( t, nx, ny, nz )
    c_bath = 1;
    T_bath = 19;
 
    if t <= T_bath
        val = c_bath;
    else
        val = NaN;
    end
    
    U = -Inf*ones( nx, ny, nz );
    U(:, :, [1, end]) = val;
 
    for i = 1:nx
        for j = 1:ny
            for k = 1:nz
                x = (i - 1)/(nx - 1);
                y = (j - 1)/(ny - 1);
 
                r = sqrt( (x - 0.5)^2 + (y - 0.5)^2 );
 
                if r >= 0.5
                    U(i, j, k) = val;
                end
            end
        end
    end
end
