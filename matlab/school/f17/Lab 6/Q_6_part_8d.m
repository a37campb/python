y = [1e-1,1e-2,1e-3,1e-4,1e-5];
s = ['r','c','b','k','l'];
for i = 1: length(y)
    [x6e,u6e] = dp45(@f6e,[0,2*pi],[2,0,0,1]', 0.001, y(i));
    c6e = (3 - u6e(1,end))/u6e(3,end);
    u6e_soln = u6e(1,:) + c6e*u6e(3,:);
    fprintf('This is for the error of');
    disp(c6e)
    disp(',')
    disp(u6e(3,end))
end