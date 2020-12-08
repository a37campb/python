format long
a = 2;
b = 3;
u_a = 1.5;
u_b = 2.5;
[x6a, u6a] = dp45( @f6a, [a, b], [u_a 0 0 1]', 0.01, 1e-4 );
c6a = (u_b - u6a(1, end))/u6a(3, end)
u6a_soln = u6a(1, :) + c6a*u6a(3, :)