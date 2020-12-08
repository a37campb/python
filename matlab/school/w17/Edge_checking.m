m = [1,1,1,1;1,3,4,1;1,2,7,1;1,1,1,1];
[rows,columns] = size(m);
top = m(1,1:end);
bottom = m(rows,1:end);
left_column = m(1:end,1);
right_column = m(1:end,columns);
left = left_column';
right = right_column';
do_i_break = 0;
for i = 1: length(right)
    if right(1,1) ~= right(1,i)
        disp('The items on the edges are not all the same.');
        do_i_break = 1;
        break
    end
end
if do_i_break ~= 1
    if all( (top == right) & (bottom == right) & (left == right) ) == 1
        disp('The items on the edge of the matrix are the same.');
    else
        disp('The items on the edge are not all the same.');
    end
end