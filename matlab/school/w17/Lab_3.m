
x = 4.5;
x_vals = [1;2;3;4;5;6];
f_x_vals = [0;6;2;1;5;10];
sum = 0;

for i = 1:length(x_vals)
    product = 1;
    for j = 1:length(x_vals)
        if i ~= j
            product = product*( x - x_vals(j) )/( x_vals(i) - x_vals(j) );
        end
    end
    sum = sum + (f_x_vals(i) * product);
end

disp(['The f(x=4.5) value is: ',num2str(sum),'.']);