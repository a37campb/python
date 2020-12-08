% 4th Order Runge-Kutta’s method
%
%
% Parameters
% ==========
%    f - the bivariate function f(y,t)
%    t_rng - the row vector containing the initial value of t and the final.
%    y0 - the initial condition.
%    n - the number of points the interval is being split up into
% Return Values
% =============
%    t_out - the row vector of the n equally spaced t values from t0 to tfinal
%    y_out - the row vector of the n y values that correspond to the t vales between t0 and tfinal

function [ t_out, y_out ] = rk4( f, t_rng, y0, n )
    % Argument Checking
    if ~all( size( t_rng ) == [1, 2] ) 
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument t_rng is not a 1x2 vector' ) );
    end
  
    if ~isscalar( y0 ) 
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument y0 is not a scalar' ) );
    end

    if ~isscalar( n ) || (n <= 0) 
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument n is not a positive scalar' ) );
    end

    if ~isa( f, 'function_handle' )
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument f is not a function handle' ) );
    end
    
    %{
    This is an imporvement on Euler's Method, such that the approximations
    are made due to an approximation to the trapezoid rule, using weighted averages
    such that the midpoint is given the most importance. This function  
    will determine the difference in the actual value, and the approximated
    value. Then it will determine the vector of the evenly spaced n points 
    between, to then fill a zero vector by finding the slope of f. 
    %}
    
    h = ( t_rng(2) - t_rng(1) ) / (n-1);
    t_out = linspace(t_rng(1),t_rng(2),n);
    a = zeros(n);
    a(1,1) = y0;
    c = [0, 1/2, 1/2, 1]';
    b = [1/6 , 1/3, 1/3, 1/6]';
    y_out = a(1,:);
    k_n = 4;
    for k=1:n-1
        K = zeros(1,k_n);
        for m = 1:k_n
            if m == 1
                K(m) = f(t_out(k),y_out(k));
            else
                K(m) = f(t_out(k) + h*c(m),y_out(k) + h*c(m)*K(m-1) );
            end
        end
        y_out(k + 1) = y_out(k) + h*K*b;
        
        %{
        K1 = f(t_out(k),y_out(k));
        K2 = f(t_out(k) + h*(1/2), y_out(k) + h*(1/2)*K1);
        K3 = f(t_out(k) + h*(1/2), y_out(k) + h*(1/2)*K2);
        K4 = f(t_out(k) + h, y_out(k) + h*K3);
        y_out(k+1) = y_out(k) + h*( (1/6)*K1 + (1/3)*K2 + (1/3)*K3 + (1/6)*K4 );
        %}
    end
end