function [ xr ] = jacobiexam( a,b,x,accuracy )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
[rows,columns] = size(a);
%xr = x;
square = 0;
if rows ~= columns && ( length(b) == rows ) && ( length(x) == rows )
    disp('Please make sure matrix a(i,j) is a square matrix and or the length of the b(i) is the same as one of the rows in a(i,j)');
    square = 1;
end

if square ~= 1
    for i = 1:rows
        d(i,1) = b(i,1) / a(i,i);
        for j = 1: columns
            if i == j
                C(i,j) = 0;
            elseif i ~= j
                C(i,j) = -1* a(i,j) / a(i,i);
            end
        end
    end
    
    
    n = 1; % To keep track of the number of iterations performered
    m=0;
    while m ~= rows
        m = 0;
        n = n+1;
        if n == 2 % for first iteration there is no xr, so I have to use x, and then create an xr
            xr_old = x;
            xr = C*x + d; % Iterative equation
        else
            xr_old = xr;
            xr = C*xr + d;
        end
        %Accuracy check
        root_error = abs((xr - xr_old)./xr) * 100;
        for i = 1:rows
            if root_error(i) < accuracy
                m = m+1;
            end
        end
    end
end
end

