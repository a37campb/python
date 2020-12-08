format long
v1 = 0;
v3 = v1;
v2 = rand;
% E/v0
b = 4;
n = linspace(0,99,100);
E_v0 = zeros(length(n),2);
T = zeros(length(n),2);
for i = 1:length(n)
    E_v0(i,1) = (n(i)*pi/b)^2 + 1;
    E = v2 * ( (n(i)*pi/b)^2 + 1);
    if E >= v2
        T(i,1)=(1+((v2^2)*(sin(n(i)*pi))^2)/(4*(E-v1)*(E-v2)))^(-1);  
    else
        T(i,1)=(1+((v2^2)*(sinh(imag(n(i)*pi)))^2)/(4*(E-v1)*(v2-E)))^(-1);
    end
end
for j = 1:length(n)
    E_v0(j,2) = (((2*n(j) + 1 )/2) *pi/b)^2 + 1;
    E = v2 * ( (((2*n(j) + 1 )/2) *pi/b)^2 + 1);
    if E >= v2
        T(j,2)=(1+((v2^2)*(sin(((2*n(j)+1)/2) *pi))^2)/(4*(E-v1)*(E-v2)))^(-1);  
    else
        T(j,2)=(1+((v2^2)*(sinh((imag(2*n(j)+1/2) *pi)))^2)/(4*(E-v1)*(v2-E)))^(-1);
    end
end


for i = 1:length(n)
    E_V0(2*i - 1) = E_v0(i,1);
    E_V0(2*i) = E_v0(i,2);
    T_long(2*i -1) = T(i,1);
    T_long(2*i) = T(i,2);
end 

%{
c = polyfit(E_V0,T_long,(n(end)*2)+1);

for i = 1:length(E_V0)
    if i == 1
        continue
    end
    E_V0(i) = c(i)*E_V0(i);
end
%}

figure
plot(E_V0, T_long);
xlabel('energy of the particle');
ylabel('Transmission Coefficient');
title('Quantum Somethin Idk Man');
