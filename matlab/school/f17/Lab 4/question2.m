format long;
x = [0,1,2,3,4,5,6];
value = 2.604215099096980;
error = zeros(1,7);
for i = 1:length(x)
    [t2a, y2a] = dp45( @f4c, [0, 1], 1, 0.1, 0.0001/(16^x(i)) );
    disp('Length:');
    disp(length(t2a));
    error(i) = abs(value - y2a(end));
    disp('Error:');
    disp(error(i));
    disp('--------------------------');
end