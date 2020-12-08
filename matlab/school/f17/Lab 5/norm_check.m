format long
z = linspace(6.6,7,100000);
m = 1;
tic;
for i = 1:length(z)
    [t5a,y5a] = dp45(@f5a, [0,z(i)],[3/10 1/2]',0.001,1e-10);
    if norm( y5a(:, end) - y5a(:,1)) < 0.001
        z_values(m) = z(i);
        m = m+1;
    end
end
disp(z_values)
toc;
disp(tic-toc);