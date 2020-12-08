function [ x ] = check_sorted( a )
%Check_Sorted Summary of this function goes here
%   Checks if a function is sorted in ascedning order.
x = 1;
for i = 1:(length(a) -1)
    if a(i) < a(i+1)
        continue
    elseif a(i+1) < a(i)
        x = 0;
        break
    end
end
end

