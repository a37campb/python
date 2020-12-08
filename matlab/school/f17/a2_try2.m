format long
v1 = 0;
v3 = v1;
v2 = -1*(rand);
m = rand;
% E/v0
b = 10;
h_bar = 1.05457180013e-34;
d = (b * h_bar)/(sqrt(2*m*v2));
x = linspace(0.1,10,100);
E = x*v2;

for i = 1:length(x)
    k2 = (sqrt(2*m*(E(i)-v2)))/h_bar;
    a2 = (sqrt(2*m*(v2-E(i))))/h_bar;
    if E <= v2
        T(i)=(1+((v2^2)*(sin(k2*d))^2)/(4*(E(i)-v1)*(E(i)-v2)))^(-1);
    else
        T(i)=(1+ ((v2^2)*(sinh(a2*d))^2) /(4*(E(i)-v1)*(v2-E(i))))^(-1);
    end
end
for i = 1:length(T)
    if i == 1 || i == length(T)
        continue 
    end
    if T(i-1) < T(i) < T(i+1)
        max_vals(i) = x(i);
    end
end

figure
plot(x, T);
xlabel('E/V0');
ylabel('Transmission Coefficient');
title('Transmission vs Energy with Beta = 10');
