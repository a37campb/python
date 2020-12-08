funct = @(n) (n+2)^2;

xi = input('Please enter your first initial guess:   ');
xi2 = input('Please enter your second initial guess:   ');
accuracy = input('How accurate do you want the root ? (in percentage %)   ');
i = 1;
xr(1) = xi;
xr(2) = xi2;
error = 100;
root_error(1) = error;
root_error(2) = error;
while error > accuracy
    i = i + 1;    
    xr(i+1) = xr(i) - ( funct( xr(i) ) * ( xr(i-1) - xr(i) ) ) / ( funct( xr(i-1) ) - funct( xr(i) ) ); 
    root_error(i+1) = abs((xr(i+1) - xr(i))/xr(i+1)) * 100;
    error = root_error(i+1);
end
fprintf('The accuracy values are %10.5f \n' , root_error);
pause
disp('-------------------------------------');
fprintf('The values of the roots for each iteration are %10.5f \n' , xr);