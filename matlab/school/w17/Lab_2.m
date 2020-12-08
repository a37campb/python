
num_row = input('Please enter the number of rows of the matrix  ');
num_column = input('Please enter the number of columns of the matrix ');
matrix = ones(num_row , num_column);
for i = 1:num_row
    for j = 1:num_column
        one_or_zero = 10;
        while ~(one_or_zero == 1 || one_or_zero == 0)
            one_or_zero = input(['Please enter either a (1/0) one or a zero , in the position (', num2str(i),',',num2str(j),'): ']);
        end
        matrix(i,j) = one_or_zero;
    end
end
disp('The matrix you entered is:');
disp(matrix)

for k = 1:num_row
    same_count = num_row;
    for o = 1 : (num_column - 1)
        if matrix(k,o) ~= matrix(k, o+1)
            same_count = same_count - 1;
        end
    end
    if same_count == num_row
        disp(['All the elements in row ',num2str(k),' are the same.']);
    end
end

T_matrix = matrix';

for k = 1:num_row
    same_count = num_row;
    for o = 1 : (num_column - 1)
        if T_matrix(k,o) ~= T_matrix(k, o+1) % For Transpose, Row is the original column
            same_count = same_count - 1;
        end
    end
    if same_count == num_row
        disp(['All the elements in column ',num2str(k),' are the same.']);
    end
end