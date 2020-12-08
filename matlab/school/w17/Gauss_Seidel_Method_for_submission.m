% Adam Campbell
% 20649284
% February 26, 2017

clear
clc

% Propmting the user for accuracy and the number of equations.
%n = input('Please enter the number of equations:   ');
accuracy = input('How accurate do you want your roots ( in percentage %) ?    ');
b_vals = [-2;45;80];
a_vals = [4,-1,-1;6,8,0;-5,0,12];
x = [1;0;0];
[rows,columns] = size(a_vals);
% setiing up Cij matrix and d column vector
for k = 1:rows
    d(k,1) = b_vals(k,1) / a_vals(k,k);
    for l = 1:rows
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
while m ~= rows
    m = 0;
    a = a+1;
    xr_old = xr; % Temporarily storing the old x-values
    % Loop that edits each x-value individually and reassigns it to the xr
    % vector.
    for i = 1:rows
        xr(i) = C(i,:)*xr + d(i,:);  % Iterative equation
    end
    %Accuracy check
    root_error = abs((xr - xr_old)./xr) * 100;
    %Since im working with multiple values of x, I have to check each of
    %them, so I do a summation of m, and if m sums to number of rows, then the loop
    %ends. (Only does this if the error is less than the accuracy.)
    for i = 1:rows
        if root_error(i,1) < accuracy
            m = m + 1;
        % This if, counts the number of divergence occurnces of the method,
        % if it is greater than 10, then the program will say it has
        % diverged. (Happens with matrices that aren't diagonally dominant)
        elseif root_error(i,1) > 100
            do_i_break = do_i_break + 1;
        end
    end

    if do_i_break == 10
        disp(' ');
        disp('Pick a better guess. The iteration  took too long to converge. ');
        break
    end 
end

%Displays output
if do_i_break ~= 10
    disp('The roots(x-values) are:  ');
    disp(xr)
end