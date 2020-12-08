c = [1,3,2];
x_bndry = [0,1];
u_bndry = [4,5];
[x,u] = bvp(c,@g2,x_bndry,u_bndry, 9);
plot( x, u, 'r.' );
