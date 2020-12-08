[t3b,y3b] = heun(@f3b,[0,1],0,11);
plot(t3b,y3b,'or');
[t3b,y3b] = ode45(@f3b,[0,1],0);
hold on
plot(t3b,y3b,'b')
title('a37campb')
