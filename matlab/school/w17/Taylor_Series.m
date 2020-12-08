syms x
n = 5;
func(x) = x^5 * sin(x^10);
xi = 1;
h = x- xi;
fx = 0;
for i = 0:n
    fx = (fx + diff(func(x),i) * h*i) / factorial(i) ;
end
disp(fx)
