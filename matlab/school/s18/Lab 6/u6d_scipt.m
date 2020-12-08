format long
nt= 150;
n_x = 33; 
n_y = 33; 
n_z = 33; 
U6d_init = zeros( n_x, n_y, n_z ); 
dU6d_init = zeros( n_x, n_y, n_z ); 
[t6d, U6d] = wave3d( 1, 1, U6d_init, dU6d_init, @u6d_bndry, [0, 60], nt ); 

disp(max( U6d( 9, 17, 17, : ) ))
frames6d = animate(U6d);
