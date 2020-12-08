% Heun’s method
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

function [ t_out, y_out ] = heun( f, t_rng, y0, n )
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
    are made due to an approximation to the trapezoid rule. This function  
    will determine the difference in the actual value, and the approximated
    value. Then it will determine the vector of the evenly spaced n points 
    between, to then fill a zero vector by finding the slope of f. 
    %}
    
    h = ( t_rng(2) - t_rng(1) ) / (n-1);
    t_out = linspace(t_rng(1),t_rng(2),n);
    a = zeros(n);
    a(1,1) = y0;
    y_out = a(1,:);
    for k=1:n-1
        K1 = f(t_out(k),y_out(k));
        K2 = f(t_out(k) + h,y_out(k) + h*K1);
        y_out(k+1) = y_out(k) + (h/2)*(K1+K2);
    end
end