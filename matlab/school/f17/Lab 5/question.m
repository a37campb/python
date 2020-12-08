[t5f,y5f] = dp45(@f5f, [0,40],[1,0.5,0.2,0.1]',0.01,1e-8);
plot( t5f, y5f(1,:), 'b' ); 
hold on
plot( t5f, y5f(3,:), 'r' );