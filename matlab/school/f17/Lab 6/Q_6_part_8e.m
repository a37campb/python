[x6f,u6f,sr] = shooting(-2.5,-2.6, @f6f,[1,3],[2,4]',0.001,1e-9,1e-9,20);
c6f = (4 - u6f(1,end))/u6f(2,end);
u6f_soln = u6f(1,:) + c6f*u6f(2,:);

for i = 2:length(x6f)
    if u6f(1,i)<u6f(1,i-1) && u6f(1,i)<u6f(1,i+1)
        x_min = x6f(i);
        u_min = u6f(1,i);
    end
end

disp(x_min)
disp(u_min)
