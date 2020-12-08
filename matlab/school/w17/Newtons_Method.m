
%funt = input('Enter the function you wish to find the root of:  ');
funct = @(n) (n+2)^2;
funct_prime = @(n) 2*(n+2);
xi = input('Please enter your initial guess:   ');
accuracy = input('How accurate do you want the root ? (in percentage %)   ');
i = 1;
xr = xi;
error = 100;
root_error = error;
while error > accuracy
    i = i + 1;    
    xr(i) = xr(i-1) - funct( xr(i-1) ) / funct_prime( xr(i-1) ); 
    root_error(i) = abs((xr(i) - xr(i-1))/xr(i)) * 100;
    error = root_error(i);
end
fprintf('The accuracy values are %10.5f \n' , root_error);
pause
disp('-------------------------------------');
fprintf('The values of the roots for each iteration are %10.5f \n' , xr);