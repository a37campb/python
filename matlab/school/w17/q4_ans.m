fit_data= [1, 0; 2, 2; 3, 7; 4, 10; 5, 11; 6, 50];
%terms=input('enter the power term');
terms=5;
total_terms=terms+1;    
% max term for the polynomial
[row_l,column_l]=size(fit_data);
% setup the big matrix [z]
for z_rows=1:total_terms
    for z_columns=1:total_terms
        z(z_rows,z_columns)=0;
        for i=1:row_l
            z(z_rows,z_columns)=z(z_rows,z_columns)+fit_data(i,1)^((z_columns-1)+(z_rows-1));
        end
    end
end
% setup the matrix [Y]
for rows=1:total_terms
    y(rows)=0;
    for i=1:row_l
        y(rows)=y(rows)+fit_data(i,2)*fit_data(i,1)^(rows-1);
    end
end
% [Z][a]=[y] => [a]=inverse [z] * [y]
a = inv(z) * y;
disp(a)