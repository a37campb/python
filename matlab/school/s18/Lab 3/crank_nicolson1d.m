% crank_nicolson1d
%
% We will use a 2nd order error approximation for the time differential and
% a 2nd order approximation for the position second differential, which 
% will allows us to implicitly solve 1D second order differential
% equations. It makes use of both the Backward Time centre spatial and the 
% Forward time center spatial approximations, essentially working as a 
% Centre Time Centre Space approximation. This function will allow for 
% approximate solutions to one dimensional, in space, heat diffusion
% equations. 

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
%    nt - number of intervals we split t_rng into.
%
% Return Values
% =============
%    x_out - all x-values used.
%    t_out - all t-values used.
%    u_out - all the approximated solutions to the diffusion equation based
%    on the CTCS scheme.

function [x_out, t_out, u_out] = crank_nicolson1d( k, x_rng, nx, t_rng, nt, u_init, u_bndry )
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
    
    % Given the constraints of this method is the constant is ideally
    % greater than 0.5. If alpha is less than 0.5, the scheme is stable but
    % begins to have oscillations dampened. Hence, we will only warn the
    % user of this fact, but will still allow the code to run.
    if alpha < 0.5
        new_nt = ceil((k*(t_rng(2)-t_rng(1)))/((h^2)*0.5) + 1);
        warning('MATLAB:questionable_argument',...
            ['The argument ' num2str(k) ' (due to nt being ' num2str(nt) ') is', ...
            ' sub-optimal, which may result in decaying ', ...
            'oscilations. Try using ' num2str(new_nt) ' keeping all other ', ...
            'parameters constant.'] );
    end
       %%====================================
       % INITIALIZATION OF SOLVING COMPONENTS
       %%====================================
       u_out = zeros(nx,nt);
       
       %%%% PREPARATION OF X_OUT AND T_OUT
       x_out = linspace(x_rng(1),x_rng(2),nx)';
       t_out = linspace(t_rng(1),t_rng(2),nt)';
       t_IC_BC_vals = t_out(2:end)'; %specifies that I always get nx-1 terms in the boundary equation.
       % The below lines of code are used to input the known approximate
       % values of u into the u_out matrix. The remainder of the matrix
       % will need to be solved for.
       u_out(1:nx,1) = u_init(x_out); 
       bndry_vals = u_bndry(t_IC_BC_vals); %separating the results of the boundary conditions
       u_out(1,2:nt) = bndry_vals(1,:); %implementing t=0
       u_out(nx,2:nt) = bndry_vals(2,:); %implementing t=t_f
       M = zeros(nx-2); % M matrix has to be the size of the unknowns we are solving for
       main_diag = 2*(1+alpha);
       other_diag = -alpha; % upper and lower  
       M = M + diag(main_diag*ones((nx-2),1)) + diag(other_diag*ones((nx-3),1),1) + diag(other_diag*ones((nx-3),1),-1);
       %%=======================================================
       % SOLVING THE CTCS DIFF FUNCTION - CALCULUS & LIN ALGEBRA
       %%=======================================================
       % The below lines of code will add to the u_out matrix, the unfilled
       % inner portion, using the diff to approximate u(i-1,k-1) -
       % 2u(i,k-1) + u(i+1,k-1).
       % u_new = u_current + alpha(difffunction value)
       % We assume that there are insulated boundaries to start, and alter M
       % to fit each type of expected insulation, and solve. If there is no
       % insulation, then we finx the assumption such that we add the known
       % boundary conditions, and then solve.
       % After the alterations are made, we will proceed with the forward
       % scheme portion to complete out CTCS.
       for i=2:nt
           u_temp =  2*u_out(2:nx-1,i-1) + alpha.*diff(u_out(1:nx,i-1),2); %% without the boundary
           if isnan(bndry_vals(1,:)) & isnan(bndry_vals(2,:)) % double insulation
                % fix the matrix M to have to correct first and last row
                M(1,1) = 2 + (2/3)*alpha;
                M(1,2) = (-2/3)*alpha;
                M(end,end-1) = (-2/3)*alpha;
                M(end,end) = 2 + (2/3)*alpha;
                u_out(2:nx-1,i) = M\u_temp;
                u_out(1,i) = (4/3)*u_out(2,i)-(1/3)*u_out(3,i); % making adjustments that the scheme could not complete
                u_out(nx,i) = (4/3)*u_out(nx-1,i)-(1/3)*u_out(nx-2,i);% making adjustments that the scheme could not complete
           elseif isnan(bndry_vals(1,:)) & (isnan(bndry_vals(2,:)) == 0) %t_0 insulation
                % fix the matrix M to have to correct first row
                M(1,1) = 2 + (2/3)*alpha;
                M(1,2) = (-2/3)*alpha;
                u_out(2:nx-1,i) = M\u_temp;
                u_out(1,i) = (4/3)*u_out(2,i)-(1/3)*u_out(3,i);% making adjustments that the scheme could not complete
           elseif (isnan(bndry_vals(1,:)) == 0) & isnan(bndry_vals(2,:)) %t_f insulation
                % fix the matrix M to have correct last row
                M(end,end-1) = (-2/3)*alpha;
                M(end,end) = 2 + (2/3)*alpha;
                u_out(2:nx-1,i) = M\u_temp;
                u_out(nx,i) = (4/3)*u_out(nx-1,i)-(1/3)*u_out(nx-2,i);% making adjustments that the scheme could not complete
           else  % no insulation
                % normal M matrix
                u_temp(1) = u_temp(1) + alpha*u_out(1,i);
                u_temp(end) = u_temp(end) + alpha*u_out(end,i);
                u_out(2:nx-1,i) = M\u_temp;
           end
       end
       return
end