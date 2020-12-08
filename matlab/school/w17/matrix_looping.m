
rows = input('Please enter the number of rows:   ');
columns = input('Please enter the number of columns:   ');
a = ones(rows,columns);
for i = 1:rows
    for j = 1:columns
        input_val = 7;
        while ~(input_val == 1 || input_val == 0)
            disp([' Please enter an input value ( 1 or 0 ) for element:', num2str(i),',',num2str(j)]);
            input_val = input('Enter your value here.  ');
        end
        a(i,j) = input_val;
    end
end
disp('The matrix you entered is: ');
disp(a);

for k = 1:rows
    similar_pair_r = 0;
    for p = 1: (columns -1)
        if a(k,p) == a(k,p+1)
            similar_pair_r = similar_pair_r + 1;
        end
    end
    if similar_pair_r == (columns - 1)
        disp(['All the elements in row', num2str(k),', are the same.']);
    end
end


for k = 1:columns
    similar_pair_c = 0;
    for p = 1: (rows -1)
        if a(p,k) == a(p+1,k)
            similar_pair_c = similar_pair_c + 1;
        end
    end
    if similar_pair_c == (rows - 1)
        disp(['All the elements in column', num2str(k),', are the same.']);
    end
end