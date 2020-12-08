% wave1d
% This function's purpose is to approximate solutions to the wave equation
% given that the speed of the wave, initial positions/states and bounded
% positions/states are given. It makes use of the finite difference
% approximations to a second order derivative and the Euler solution to
% solving for future time positions in u(x,t).

% Parameters
%===========
% u_init - this is the function which denotes the initial spatial values of the 
% function u(x_0,t) for all time t. 
% du_init - this is a function which returns a n-dimensional column vector
% (denoting the initial speeds) when an n-dimensional column vector is
% supplied as input. 
% u_bndry - this is a function which denotes the final spatial values of
% the function u(x_f,t) for all time t.
% c - this is the speed of the wave
% x_int - this is the interval of space the wave is propogating across.
% This is represented as a 2-dimensional row vector.
% t_int - this is the interval of time the wave is propogating for. This is
% representad as a 2-dimensional row vector. 

% Return Values
%===============
% x_out - this is the linspace of all the space used for the approximations
% of u_out.
% t_out - this is the linspace of all the time used for the approximations
% of u_out.
% u_out - this is the nx X nt matrix of all approximated u(x,t) values for
% each combination of x and t. 

function [ x_out,t_out,u_out ] = wave1d( c,x_int,nx, t_int,nt, u_init ,du_init ,u_bndry )
% Argument checking

    if ~all( size( x_int ) == [1, 2] ) 
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument x_rng is not a 2-dimensional row vector' ) );
    end
    
    if ~all( size( t_int ) == [1, 2] ) 
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument t_rng is not a 2-dimensional row vector' ) );
    end
    
    if ~isa( u_init, 'function_handle' )
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument u_init is not a function handle' ) );
    end
    
    if ~isa( du_init, 'function_handle' )
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument u_init is not a function handle' ) );
    end
    
    if ~isa( u_bndry, 'function_handle' )
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument u_bndry is not a a function handle' ) );
    end
  
    if ~isscalar( c ) 
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

    %====================================
    % Step 0: Initialization of Variables
    %====================================
    % We must initialize the values of dt, h.
    
    dt = (t_int(2) - t_int(1))/(nt-1);
    h = (x_int(2) - x_int(1))/(nx-1);
    r = ((c*dt)/h)^2;
    %=======================
    % Step 1: Error Checking
    %=======================
    if r >= 1
        new_nt = ceil((c/h)*(t_int(2) - t_int(1))+1);
        throw( MException( 'MATLAB:invalid_argument', ...
        ['The error of the system (c*dt/h)^2 is greater than or equal to',...
        ' 1. As such you need to try running the function with nt being',...
        ' an integer greater than or equal to ' num2str(new_nt) ' along',...
        ' with the other given parameters.'] ));
    end
    %========================
    % Step 2: Initialization
    %========================
    u_out = zeros(nx,nt);
    % Preparation of x_out and t_out for return.
    %===========================================
    x_out = linspace(x_int(1),x_int(2),nx);
    t_out = linspace(t_int(1),t_int(2),nt);
    %After initialization we will apply the boundary conditions
    %==========================================================
    u_out(:,1) = u_init(x_out);
    t_bndry_vals = t_out(2:end);
    bndry_vals = u_bndry(t_bndry_vals);
    u_out(1,2:end) = bndry_vals(1);
    u_out(nx,2:end) = bndry_vals(2);
    %================
    % Step 3: Solving
    %================
    for i = 2:nt
       if i == 2
           % Solving the special case of t_2
           %=================================
           % Since we do not have access to u(i,0) we use a Euler approximation to
           % get the value is u(x,t_2).
           u_out(2:nx-1,i) = u_out(2:nx-1,i-1) + dt*du_init(u_out(2:nx-1,i-1));
       else
           % Solving the rest of the inner matrix
           %=====================================
           u_out(2:nx-1,i) = 2*u_out(2:nx-1,i-1) - u_out(2:nx-1,i-2)+ r*diff(u_out(:,i-1),2);
       end
       % Accounting for Insulated Systems
       %=================================
       if isnan(bndry_vals(1,:)) & isnan(bndry_vals(2,:)) % double insulation
            % fix the values at x_0 and x_f directly since there is no Crank_nicolson
            u_out(1,i) = (4/3)*u_out(2,i)-(1/3)*u_out(3,i);
            u_out(nx,i) = (4/3)*u_out(nx-1,i)-(1/3)*u_out(nx-2,i);
       elseif isnan(bndry_vals(1,:)) & (isnan(bndry_vals(2,:)) == 0) %t_0 insulation
            % fix the values at x_0 directly since there is no Crank_nicolson
            u_out(1,i) = (4/3)*u_out(2,i)-(1/3)*u_out(3,i);
       elseif (isnan(bndry_vals(1,:)) == 0) & isnan(bndry_vals(2,:)) %t_f insulation
            % fix the values at x_f directly since there is no Crank_nicolson
           u_out(nx,i) = (4/3)*u_out(nx-1,i)-(1/3)*u_out(nx-2,i);
       end
    end
    return
end
