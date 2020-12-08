function [U] = U6c_bndry_harder( t, n_x, n_y )
    U = -Inf*ones( n_x, n_y );
 
    for j = 1:n_x
        for k = 1:n_y
            % (x, y) is a point in [0, 1] x [0, 1]
            x = 2*((j - 1)/(n_x - 1));
            y = (2*((k - 1)/(n_y - 1)))-0.5;
        
            % Determine if a point is outside a circle of radius 0.5
            % centred at the point (0.5, 0.5)
            %if sqrt( (x - 0.5)^2 + (y - 0.5)^2 ) >= 0.5
            if sqrt((x-1)^2+(y-0.5)^2) >= 1   
                 U(j, k) = NaN;
            end
        end
    end
end
