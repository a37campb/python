function [y_value] = lab3(x)

x_vals = [1;2;3;4;5;6];
f_x_vals = [0;6;2;1;5;10];
y_value = 0;

for i = 1:length(x_vals)
    product = 1;
    for j = 1:length(x_vals)
        if i ~= j
            product = product*( x - x_vals(j) )/( x_vals(i) - x_vals(j) );
        end
    end
    y_value = y_value + (f_x_vals(i) * product);
end

end