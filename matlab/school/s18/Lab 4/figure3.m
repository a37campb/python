T = 6.25;
n = 100;
[x4a, t4a, U4a] = wave1d( 1, [0,pi],  10, [0, 3*T], 3*n+1, @u4a_init, @du4a_init, @u4a_bndry );
x = linspace(0,pi,100);
y = sin(x);
plot(x,y,'-r',x4a,U4a(:,1),'ro',x4a,U4a(:,n+1),'ms',x4a,U4a(:,2*n+1),'cp',x4a,U4a(:,3*n+1),'bh');
