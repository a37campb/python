function [U] = u6c_bndry_2( t, n_x, n_y)
    % Set the space equal to -Inf
    U = -Inf*ones( n_x, n_y);
    
    % loop over space to construct an ellipical boundary
    for j = 1:n_x
        for k = 1:n_y
            % (x,y) is a point in [0,1] x [0,1]
            x = 2*(j-1)/(n_x - 1);
            y = (k-1)/(n_y - 1);
            
            % Determine if a point ouside the ellipse has a = sqrt(0.5) and
            % b = 0.5, and assign NaN
            if ((x-1)^2)/(0.5) + ((y-0.5)^2)/(0.5^2) >= 1
                U(j,k) = NaN;
            end
        end
    end
end