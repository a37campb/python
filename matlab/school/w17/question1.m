
function [ answer ] = question1( xi,accuracy )
%UNTITLED2 Summary of this function goes here
%   This function runs the Newton-Raphson method, using symbolic 
%   functions. Makes use of a while loop until acceptable convergence is noticed.

syms y
funct(y) = exp(-y) - y;
funct_prime = diff(funct);
i = 1;
x(1) = xi;
error = 100;
while error > accuracy    
    x(i+1) = x(i) - funct( x(i) ) / funct_prime( x(i) ); 
    error(i+1) = abs((x(i+1) - x(i))/x(i+1)) * 100;
    i = i + 1;
end
answer = double(x(i));
end

