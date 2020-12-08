% diffusion1d
%
% We will use a 1st order error approximation for the time differential and
% a 2nd order approximation for the position second differential, which 
% will allows us to Bawkward Time centre special approximations. This 
% function will allow for approximate solutions to one dimensional, in
% space, heat diffusion equations. 

% Parameters
% ==========
%    k - a heat diffusion equation constant.
%    x_rng - 2 dimensional row vector showing bounds of distance.
%    t_rng - 2 dimensional row vector showing bounds of time.
%
%    u_init - Must be  function handle that provides the initial values of
%    u as a column vector. The function handle must also accept a column
%    vector of x values.
%    u_bndry - Must be  function handle that provides the boundary values
%    (initial and final) for the steps in time of u as a 2 by (nt-1) dimensional
%    matrix. The function handle must also accept a column
%    vector of t values.
%
%    nx - number of intervals we split x_rng into.
%    nt - number of intervals we split x_rng into.
%
% Return Values
% =============
%    x_out - all x-values used.
%    t_out - all t-values used.
%    u_out - all the approximated solutions to the diffusion equation.

function [x_out, t_out, u_out] = diffusion1d( k, x_rng, nx, t_rng, nt, u_init, u_bndry )

%Argument Checking

    if ~all( size( x_rng ) == [1, 2] ) 
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument x_rng is not a 2-dimensional row vector' ) );
    end
    
    if ~all( size( t_rng ) == [1, 2] ) 
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument t_rng is not a 2-dimensional row vector' ) );
    end
    
    if ~isa( u_init, 'function_handle' )
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument u_init is not a function handle' ) );
    end
    
    if ~isa( u_bndry, 'function_handle' )
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument u_bndry is not a a function handle' ) );
    end
  
    if ~isscalar( k ) 
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument k is not a scalar' ) );
    end

    if ~isscalar( nx ) || ( nx ~= round( nx ) ) || (nx < 0)   
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument nx is not a positive integer' ) );
    end
    
    if ~isscalar( nt ) || ( nt ~= round( nt ) ) || (nt < 0)   
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument nt is not a positive integer' ) );
    end
    
    %%===========================
    % INITIALIZATION OF CONSTANTS
    %%===========================
    %Initializing Constants and forming the linspaces for t_out and x_out. 
    h = (x_rng(2)-x_rng(1))/(nx-1);
    dt = (t_rng(2)-t_rng(1))/(nt-1);
    %Setting the constant to be just a variable, for simplicity.
    alpha = k*dt/(h^2);
    
    %%==============
    % ERROR CHECKING
    %%==============
    % Here we will use the initialized values to determine if given the 
    % parameters, we can continue with the BTCS method of approximation.
    
    % Given the constraints of this method is the constant is greater than
    % 0.5, we will find the solution to be unstable. Hence, we will only
    % proceed is the constant is less than 0.5.
    if alpha < 0.5 
       %%====================================
       % INITIALIZATION OF SOLVING COMPONENTS
       %%====================================
       u_out = zeros(nx,nt);       
       % The below lines of code are used to input the known approximate
       % values of u into the u_out matrix. The remainder of the matrix
       % will need to be solved for. But first, we need x_out and t_out.
       %%%% PREPARATION OF X_OUT AND T_OUT
       x_out = linspace(x_rng(1),x_rng(2),nx)';
       t_out = linspace(t_rng(1),t_rng(2),nt)';
       t_IC_BC_vals = t_out(2:end)'; %specifies that I always get nx-1 terms in the boundary equation.
       u_out(1:nx,1) = u_init(x_out);
       bndry_vals = u_bndry(t_IC_BC_vals); %separating the results of the boundary conditions
       u_out(1,2:nt) = bndry_vals(1,:); %implementing t=0
       u_out(nx,2:nt) = bndry_vals(2,:); %implementing t=t_f
       %%=========================================
       % SOLVING THE BTCS DIFF FUNCTION - CALCULUS
       %%=========================================
       % The below lines of code will add to the u_out matrix, the unfilled
       % inner portion, using the diff to approximate u(i-1,k-1) -
       % 2u(i,k-1) + u(i+1,k-1).
       % u_new = u_current + alpha(difffunction value)
       for i=2:nt
           u_out(2:nx-1,i) = u_out(2:nx-1,i-1) + alpha.*diff(u_out(1:nx,i-1),2); 
       end
       return
    else 
        new_nt = ceil((k*(t_rng(2)-t_rng(1)))/((h^2)*0.5) + 1);
        throw( MException( 'MATLAB:invalid_argument', ...
        ['The error of the system (k*dt/h^2) is greater than or equal to',...
        ' 0.5. As such you need to try running the function with nt being',...
        ' an integer greater than or equal to ' num2str(new_nt) ' along',...
        ' with the other given parameters.'] ));
    end
end