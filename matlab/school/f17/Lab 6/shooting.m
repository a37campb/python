% shooting
% 
% The shooting method uses a previously coded dp45 (that handles coupled
% differential equations) and the secant method. It uses both of these to
% find the appropriate boundaries for the differential equation, from the
% initial valued ODE. After the bounds have been found, we can then use
% dp45, to solve the ODE using the approximated Boundry Values, found using
% the shooting method.
%
% Parameters
%
% For each parameter, give a brief description of the purpose of that parameter
%
%    s1        The first approximation of the slope of err_shot (helper
%              function)
%    s2        The second approximation of the slope of err_shot (helper
%              function)
%    f         The differenctial equation being solved by numerical methods
%    x_rng     Row vector defining the range of the boundary value problem
%    u_bndry   Vector containing the boundary conditions
%    h         Initial step size for dp45 (helper function)
%    eps_abs   absolute error, used in both the secant method and dp45
%    eps_step  absolute step size for the secant method.
%    N_max     Max number of iterations for the secant method
%
% Return Values
%
% For each return value, give a brief description of its values
%
%   x_out  The x-value at which the second boundary for the bvp is found at
%   u_out  The vector of approximated second boundary for the bvp ( fr each
%          iteration.)


function [x_out, u_out, sr] = shooting(s1,s2,f,x_rng,u_bndry,h, eps_abs, eps_step,N_max)
    %Type checking
    if ~all( size( x_rng ) == [1, 2] ) 
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument x_rng is not a 1x2 vector' ) );
    end
    
    if ~all( size( u_bndry ) == [2, 1] ) 
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument u_bndry is not a 1x2 vector' ) );
    end
    
    if ~isscalar( N_max ) || (N_max <= 0) 
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument N_max is not a positive scalar' ) );
    end

    if ~isscalar( h ) || (h <= 0) 
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument h is not a positive scalar' ) );
    end
    
    if ~isscalar( s1 )  
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument s1 is not a scalar' ) );
    end
    
    if ~isscalar( s2 ) 
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument s2 is not a scalar' ) );
    end
    
    if ~isscalar( eps_abs ) || (eps_abs <= 0) 
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument eps_abs is not a positive scalar' ) );
    end
    
     if ~isscalar( eps_step ) || (eps_step <= 0) 
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument eps_step is not a positive scalar' ) );
    end
    
    if ~isa( f, 'function_handle' )
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument f is not a function handle' ) );
    end
    
    %Secant Method
    for i = 1:N_max
        err2 = err_shot(s2,f, x_rng, u_bndry, h, eps_abs);
        err1 = err_shot(s1,f, x_rng, u_bndry, h, eps_abs);
        if abs(err1) < abs(err2)
            a = s1;
            s1 = s2;
            s2 = a;
            %This is assuming that s2 is more accurate.
        end
        %Define the err(s1) and err(s2) for the appropriate slope values, as
        %it is a lot of type, since they are required below.
        s = (s1*err2 - s2*err1)/(err2 - err1); 
        %{
        Solving for s using the secant method
        The most accurate s (closest to the solution of the function
        err_shot) will be used in dp45 below)
        %}
        sr(i) = s; %Adding all of the s values to a vector for future use.
        errs = err_shot(s,f, x_rng, u_bndry, h, eps_abs);
        %Defining the function err(s) for the approximated solution, as it
        %is a lot of code. Just for aesthetics. 
        
        if abs(s2 - s) < eps_step && abs(errs) < eps_abs
            break
        else
            s1 = s2;
            s2 = s;
        end
        %{
        The above if statement checks to see if we need to continue our
        for loop. We hault as per the condition, and continue if we fail to
        meet it.
        %}
    end
    %%%End of secant method
    %The same condition in the for loop is present here, as we could never
    %meet the condition, and have a poor approximation of s. So we check
    %again to see if we just ran out of iterations. If we did, an error is
    %thrown.
    
    if abs(s2 - s) < eps_step && abs(errs) < eps_abs
        [x_out, u_out] = dp45( f, x_rng, [u_bndry(1), s]', h, eps_abs );
        %Our dp45, from Lab 5 is used to solve for the boundary condition,
        %from the original initial value problem. Further work can hen be
        %done to solve for the solutions of the ODE.
        
    else
        throw( MException( 'The secant Method failed to find a solution.',...
            'Try using different paramters.' ) );
    end
end