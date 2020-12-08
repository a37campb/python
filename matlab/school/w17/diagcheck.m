function [ result ] = diagcheck( matrix )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[rows,columns] = size(matrix);
result = 1;
compare_to = matrix(1,1);
if rows == columns
    for i = 1:rows
        if result == 0
            break
        end
        for j = 1: columns
            if i == 1 && j == 1 
                continue
            elseif i == j
                if matrix(i,j) ~= compare_to
                    result = 0;
                    break
                end
            end
        end
    end
    for i = rows: -1: 1
        if result == 0
            break
        end
        for j = 1:columns
            if (i + j) == rows + 1
                if matrix(i,j) ~= compare_to
                    result = 0;
                    break
                end
            end
        end
    end  
else  
    if rows >= columns
        max = rows;
    else 
        max = columns;
    end
    for i = 1:rows
        if result == 0
            break
        end
        for j = 1: columns
            if i == 1 && j == 1 
                continue
            elseif i == j
                if matrix(i,j) ~= compare_to
                    result = 0;
                    break
                end
            end
        end
    end
    for i = rows: -1: 1
        if result == 0
            break
        end
        for j = 1:columns
            if (i + j) == max + 1
                if matrix(i,j) ~= compare_to
                    result = 0;
                    break
                end
            end
        end
    end
end
end