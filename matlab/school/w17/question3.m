
function [ answer ] = question3( num )
%UNTITLED2 Summary of this function goes here
%   This function calculates the approximation of the the integral of 
%   exp^(-x^2), using a maclaurin's approximation.
%   Also makes use of the symbolic function, and the built in integral
%   function.
syms x
funct = 0;
for n = 0: num - 1
    funct = funct + ( (-1)^n ) * ( (x^(2*n) ) /factorial(n) );
end
ans = int(funct,x,0,1);
answer = double(ans);
end