
function [ max_ans ] = question2( x_a,x_b,accuracy )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
funct = @(x) 2*sin(x) - (x^2)/10;
R = (5^(1/2) - 1 )/2;
x_lower = x_a;
x_upper = x_b;
i = 1;
error(i) = 100;
while error(i) > accuracy
    d = R*(x_upper - x_lower);
    x1(i) = x_lower + d;
    x2(i) = x_upper - d;
    f_x_1 = funct( x1(i) );
    f_x_2 = funct( x2(i) );
    if f_x_1 > f_x_2
        x_lower = x2(i);
        max_ans = x2(i);
        error(i+1) = (1-R)* abs( (x_upper - x_lower)/max_ans ) * 100;
    else
        x_upper = x1(i);
        max_ans = x1(i);
        error(i+1) = (1-R)* abs( (x_upper - x_lower)/max_ans ) * 100;
    end
    i = i+1;
end
end