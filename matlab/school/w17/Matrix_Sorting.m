%{
rows = input('Please enter the number of rows for the matrix MATR.  ');
columns = input('Please enter the number of columns for the matrix MATR.  ');
for i = 1:rows
    for j = 1:columns
        MATR(i,j) = input(['Please enter the number corresponding to the position, (',num2str(i) ,',',num2str(j),').  ']);
    end
end
%}

MATR = [5,4,3,2,1;5,4,3,2,1;5,4,3,2,1;5,4,3,2,1;5,4,3,2,1;5,4,3,2,1;5,4,3,2,1;5,4,3,2,1;5,4,3,2,1;5,4,3,2,1;5,4,3,2,1;5,4,3,2,1;5,4,3,2,1;5,4,3,2,1;5,4,3,2,1;5,4,3,2,1];

[rows,columns] = size(MATR);
MATR_old = MATR;

for i = 1:rows
    x = MATR(i,1:end);
    counter = 0;
    result = 0;
    for z = 1 : (columns - 1)
        if x(z) < x(z+1)
            counter = counter + 1;
        end
    end
    if counter == (columns - 1)
        result = 1;
    end
    
    while result ~= 1
        for v = 1 : (columns - 1)
               if x(v) > x(v+1)
                   temp = x(v);
                   x(v) = x(v+1);
                   x(v+1) = temp;
               elseif x(v) < x(v+1)
                   continue
               end
        end
        
        counter = 0;
        result = 0;
        for z = 1 : (columns - 1)
            if x(z) < x(z+1)
                counter = counter + 1;
            end
        end
        if counter == (columns - 1)
            result = 1;
        end
        MATR(i,1:end) = x;
    end
end

disp('The matrix you entered is: ');
disp(MATR_old);
disp('The sorted matrix is: ');
disp(MATR);
