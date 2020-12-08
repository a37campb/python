% Adam Campbell
% 20649284
% February 7, 2017

clear
clc

% Propmting the user for accuracy and the number of equations.
n = input('Please enter the number of equations:   ');
accuracy = input('How accurate do you want your roots ( in percentage %) ?    ');

%Getting the values to put into matrices (a and b)
for i = 1:n
    b_val_input = input('Please enter a b-value (This is the result of your equation):    ');
    b_vals(i,1) = b_val_input;
    
    % Only asking the user for one of the guesses, then sets the remaining
    % x-values to zero.
    if i == 1
        x_vals = input(['Please enter the x',num2str(i),' guess:  ']);
        x(i,1) = x_vals;
    elseif i > 1
        x(i,1) = 0; 
    end
    
    for c = 1:n
        a_val_input = input(['Please enter the a-value(constant) coresponding to x',num2str(c),'  ']);
        a_vals(i,c) = a_val_input;
    end
    
end

% Check for diagonally dominant matrix
diagonal_count = 0;

for i = 1:n
    summation = 0;
    for j = 1:n
        if i ~= j
            summation = summation + abs( a_vals(i,j) );
        end
    end
    if summation < abs( a_vals(i,i) )
        diagonal_count = diagonal_count + 1;
    end
end

if (diagonal_count == n) % Cheking if diagonally dominant, then the code will run, if not, the error statement will be printed.
    xr_output = x_vals;
    % setiing up Cij matrix and d column vector
    for k = 1:n
        d(k,1) = b_vals(k,1) / a_vals(k,k);
        for l = 1:n
            C(k,l) = -1*a_vals(k,l)/a_vals(k,k) ;
            if k == l
                C(k,l) = 0;
            end
        end
    end
    
    xr = x;
    do_i_break = 0; % A counter for the check for divergence
    a = 1; % To keep track of the number of iterations performered
    m = 0; % Initialization of part of the condition for the iterative loop
    while m ~= n
        m = 0;
        xr_output(1:n , a)= xr(1:end,1);
        a = a+1;
        xr_old = xr; % Temporarily storing the old x-values
        % Loop that edits each x-value individually and reassigns it to the xr
        % vector.
        for i = 1:n
            xr(i) = C(i,:)*xr + d(i,:);  % Iterative equation
        end
        %Accuracy check
        root_error = abs((xr - xr_old)./xr) * 100;
        %Since im working with multiple values of x, I have to check each of
        %them, so I do a summation of m, and if m sums to n, then the loop
        %ends. (Only does this if the error is less than the accuracy.
        for i = 1:n
            if root_error(i,1) < accuracy
                m = m + 1;
            % This if, counts the number of divergence occurnces of the method,
            % if it is greater than 10, then the program will say it has
            % diverged. (Happens with matrices that aren't diagonally dominant)
            elseif root_error(i,1) > 100
                do_i_break = do_i_break + 1;
            end
        end
        
        errors(1:n , a) = root_error(1:end,1);
        
        if do_i_break == 10
            disp(' ');
            disp('Pick a better guess. The iteration diverged. ')
            break
        end 
    end

    %Displays output
    if do_i_break ~= 10
        disp(' ');
        disp('The error in the roots(x-values) are:  ');
        disp(root_error)
        pause
        disp('The roots(x-values) are:  ');
        disp(xr)
        disp('The number of iterations used for this error is:');
        disp(a-1)
        divergence = input('Would you like to know how many times the iteration diverged before converging ? (Y for yes, N for no) ','s');
        
        if divergence == 'Y' || divergence == 'y'
            disp(' ');
            disp(['The iterative method diverged ', num2str(do_i_break),' times before converging.']);
        end
        
        all_iterative_results = input('Would you like to see all the iteratuve results ? (x-values and errors) [Y for yes, N for no]  ','s');
        
        if all_iterative_results == 'Y' || all_iterative_results == 'y'
            disp(' ');
            disp('The errors are:');
            disp(errors);
            disp(' ');
            disp('The x-values for each iteration are:');
            disp(xr_output);
        end
    end
else
    disp(' ');
    disp('The matrix entered is not diagonally dominant, and hence the Gauss-Seidel Iteration method will diverge.');
    disp(' ');
    disp('Please choose a diagonally dominant system of equations to be entered into the system.');
end