[t4b, y4b] = rk4( @f4b, [0, 1], 0, 11);
plot( t4b, y4b, 'or' )
[t4b, y4b] = ode45( @f4b, [0, 1], 0 );
hold on
plot( t4b, y4b, 'b' )