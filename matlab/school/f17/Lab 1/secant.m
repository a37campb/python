function[x2] = secant(f,x0,x1,eps_step,eps_abs,Nmax)
%{
This function is meant to find the root of an equation using the secant
method.

f represents the function of x.
x0 represents the initial starting point.
x1 represents the first guess of the root.
eps_step represents the degree of error acceptable in the x.
eps_abs represents the degree of error acceptable in the y.
x2 is the root of the equation f.
Nmax represents the highest number of iterations to run.
%}
    for i = 1:Nmax    % This loop is to limit the number of iterations of the secant method.
        x2 = x1 - (f(x1) * (x0 - x1)) / (f(x0) - f(x1));  %A calculation of the root, using the secant method.
        if abs(x2 -x1) < eps_step && abs(f(x2)) < eps_abs  %Checks for error range (convergence).
            return;
        end
        x0 = x1; %This line and the one below is a reording of variable for furture iterations.
        x1 = x2;
    end
    throw(MException('MATLAB:numeric_exception','Did not find convergence')); %Outputs a detailed error, explaining why the function failed.
end