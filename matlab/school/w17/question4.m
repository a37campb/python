
function [ coefficients ] = question4 ( matrix,n_user )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    [rows,~] = size(matrix);
    n = n_user + 1;
    %dealing with the big matrix for the left.. say, B
    for b_rows = 1:n
        for b_columns = 1:n
            B(b_rows,b_columns) = 0;
            for i = 1:rows
                B(b_rows,b_columns) = B(b_rows,b_columns)+ matrix(i,1) ^ ( (b_columns - 1) + (b_rows - 1) );
            end
        end
    end
    %dealing with the matrix on right the smaller one, say P 
    
    for p_rows =  1:n
        P(p_rows,1) = 0;
        for m = 1:rows
            P(p_rows,1) = P(p_rows,1) + matrix(m,2) * (matrix(m,1) ^ ( p_rows - 1 )) ; 
        end
    end
    coefficients = flip( inv(B) * P );
 end