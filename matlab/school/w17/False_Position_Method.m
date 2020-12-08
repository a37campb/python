funct = @(n) cos(n);
xu = input('Please enter your upper-limit    ');
xl = input('Please enter your lower limit:   ');
accuracy = input('How accurate do you want the root ? (in percentage %)   ');
i = 0;
error = 100;
while error > accuracy
    i = i + 1;
    xr(i) = xu - ( (funct(xu) * (xl - xu) ) / (funct(xl) - funct(xu) ) );
    f_of_xu = funct(xu);
    f_of_xl = funct(xl);
    f_of_xri = funct(xr(i));
    if abs(f_of_xl - f_of_xri) < abs(f_of_xu - f_of_xri)
        xl = xr(i);
    elseif abs(f_of_xl - f_of_xri) > abs(f_of_xu - f_of_xri)
        xu = xr(i);
    end
    if i == 1
        root_error(i) = error;
    end
    if i > 1
        root_error(i) = abs((xr(i) - xr(i-1))/xr(i)) * 100;
        error = root_error(i);
    end
end
fprintf('The accuracy values are %10.5f \n' , root_error);
pause
disp('-------------------------------------');
fprintf('The values of the roots for each iteration are %10.5f \n' , xr);
