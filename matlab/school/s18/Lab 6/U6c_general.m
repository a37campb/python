n = 101;
U6c_init = zeros( n, n );
dU6c_init = zeros( n, n );
 
for j = 1:n
    for k = 1:n
        % (x, y) is a point in [0, 1] x [0, 1]
        x = (j - 1)/(n - 1);
        y = (k - 1)/(n - 1);
        
        % The initial disturbance is centred at (0.25, 0.5)
        U6c_init(j, k) = exp( -1000*((x - 0.25)^2 + (y - 0.5)^2) );
    end
end
 
[t6c, U6c] = wave2d( 1, 1, U6c_init, dU6c_init, @U6c_bndry, [0, 300], 650 );
%frames6c = animate( U6c );
