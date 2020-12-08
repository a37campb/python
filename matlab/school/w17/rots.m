function [ root1,root2 ] = rots( a,b,c )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
root1 = (-b - (b^0.5 -4*a*c)^0.5) / 2*a;
root2 =  (-b + (b^0.5 -4*a*c)^0.5) / 2*a;

fprintf('The results are approximately: %s %s \n ', num2str(root1) , num2str(root2))

end

