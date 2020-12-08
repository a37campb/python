function [ a ] = Sort ( a )
%Sort Summary of this function goes here
%Checks if a function is sorted in ascedning order.
check = check_sorted(a);
while check == 0
    for i = 1: length(a) -1
        if a(i) <= a(i+1)
           continue
        else
            lower = a(i+1);
            higher = a(i);
            a(i+1) = higher;
            a(i) = lower;
        end
    end
    check = check_sorted(a);
end    
disp(a)
end