function [t_out,y_out] = dp45( f, t_rng, y0, h, eps_abs )   
% Argument Checking
    if ~all( size( t_rng ) == [1, 2] ) 
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument t_rng is not a 1x2 vector' ) );
    end
    
    [N,y0_cols] = size(y0);
    
    if y0_cols ~= 1 
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument y0 is not a a column vector' ) );
    end

    if ~isscalar( h ) || (h <= 0) 
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument h is not a positive scalar' ) );
    end
    
    if ~isscalar( eps_abs ) || (eps_abs <= 0) 
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument eps_abs is not a positive scalar' ) );
    end
    
    if ~isa( f, 'function_handle' )
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument f is not a function handle' ) );
    end
    
% Dormand-Prince's method
%
% The purpose of the Dormand-Prince method is to estimate the value
% of a function at some point, y,  given the initial value (y0) and the slope
% of the function at some point y.
%
% This version is used to find the solution to the coupled set of ODEs.
% Parameters
% ==========
%    f - the bivariate function f(y,t)
%    t_rng - the row vector containing the initial value of t and the final.
%    y0 - the column vectors of N initial conditions
%    h - the step size
%    eps_abs - the absolte error of the results.
% Return Values
% =============
%    t_out - the row vector of the n equally spaced t values from t0 to tfinal
%    y_out - the row vector of the n y values that correspond to the t vales between t0 and tfinal
    
    %{
    This is an improvement on Euler's Method, such that the approximations
    are made due to an approximation to the trapezoid rule, using weighted averages
    such that the midpoint is given the most importance. This function  
    will determine the difference in the actual value, and the approximated
    value. Then it will determine the vector of the evenly spaced n points 
    between, to then fill a zero vector by finding the slope of f. 
    %}

    %Define Butcher Tableau values
    A = [ 0          0         0        0         0        0   0; 
      1          0         0        0         0        0   0;
     1/4        3/4        0        0         0        0   0;
    11/9      -14/3      40/9       0         0        0   0;
  4843/1458 -3170/243  8056/729  -53/162      0        0   0;
  9017/3168  -355/33  46732/5247  49/176 -5103/18656   0   0;
    35/384       0      500/1113 125/192 -2187/6784  11/84 0]';

    by = [5179/57600 0 7571/16695 393/640 -92097/339200 187/2100 1/40]';
    bz = [  35/384   0  500/1113  125/192  -2187/6784    11/84    0]';
    
    c = [0 1/5 3/10 4/5 8/9 1 1]';
    
    k_n = 7;
    K = zeros(N, k_n);

    % Initialize t_out and y_out (vector now)
    t_out = t_rng(1);
    y_out(:,1) = y0; 
    
    % Initialize k
    k = 1;
    % Calculating the approximation by iterating Runge-Kutta method n-1 times
    while t_out(k) < t_rng(2)    
        for m = 1:k_n
            K(:,m) = f(t_out(k) + h*c(m), y_out(:,k) + h*c(m)*K*A(:,m));
        end
   
        % Approximating y_tmp and z_tmp
        y_tmp = y_out(:,k) + h*K*by;
        z_tmp = y_out(:,k) + h*K*bz;
        
        % Calculate s (now needs a norm, and not absolute value, to give a
        % scalar rather than a matrix.
        s = ((eps_abs)*h/(2*(t_rng(2) - t_rng(1))*norm(y_tmp - z_tmp)))^(1/4);
        
        % Determine s and modify h as appropriate. Checks for if h must be
        % change mid run.
        if s >= 2
            y_out(:,k+1) = z_tmp;
            t_out(:,k+1) = t_out(k) + h;
            k = k+1;
            h = 2*h;
        elseif s >= 1
            y_out(:,k+1) = z_tmp;
            t_out(:,k+1) = t_out(k) + h;
            k = k+1;
        else
            h = h/2;
        end
        % Final check
        if t_out(k) + h > t_rng(2)
            h = t_rng(2) - t_out(k);
        end
    end
end