[x6d,u6d] = dp45(@f6d,[-1,1],[2,0,0,1]', 0.001, 1e-10);
c6d = (3 - u6d(1,end))/u6d(3,end);
u6d_soln = u6d(1,:) + c6d*u6d(3,:);
plot(x6d, u6d_soln, 'r')
title('zdenno and a37campb')