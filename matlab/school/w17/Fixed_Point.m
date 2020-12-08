xi = input('Please enter your initial guess  ');
accuracy = input('Please enter how accurate you want your root to be in %.   ');
error = 100;
f_of_x = @(x) exp(-x) - x;
g_of_x = @(x) exp(-x);
errors = error;
xr = xi;
i = 1;
while error >= accuracy
    i = i + 1;
    xr(i) = g_of_x( xr(i-1) );
    error = abs( ( (xr(i) - xr(i-1))/xr(i) ) * 100 );
    errors(i) = error;
end

disp('After the iteration, the root and it`s associated error is:');
disp([xr(i),errors(i)]);
disp('');
view_results = input('Do you want to see all results from the iteration ? (Y for yes, N for no) ','s');
if view_results == 'Y' || view_results == 'y'
    disp('');
    disp('The roots are:');
    disp(xr);
    pause
    disp('The errors are:');
    disp(errors);
end