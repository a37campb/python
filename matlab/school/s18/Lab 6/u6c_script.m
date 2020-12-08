nx = 201;
ny = 101;
U6c_init = zeros( nx, ny );
dU6c_init = zeros( nx, ny );
 
for j = 1:nx
    for k = 1:ny
        % (x, y) is a point in [0, 1] x [0, 1]
        x = 2*(j - 1)/(nx - 1);
        y = (k - 1)/(ny - 1);
        
        % The initial disturbance is centred at (0.25, 0.5)
        U6c_init(j, k) = exp( -1000*((x - 0.5)^2 + (y - 0.5)^2) );
    end
end
 
[t6c, U6c] = wave2d( 1, 1, U6c_init, dU6c_init, @u6c_bndry_2, [0, 300], 650 );
[z_min, t_min] = min( U6c(151, 51, :) );
disp(t6c( t_min ));
frames6c = animate( U6c );

