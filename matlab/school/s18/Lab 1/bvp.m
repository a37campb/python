% bvp
% Boundary values will be used to determine approximate solutions to a linear ordinary differentia equation. 
%The linear ordinary differential equations represents a line where we aim to find x and u values on the individual line, between the two supplied boundaries.
%
% Parameters
% ==========
%    c -  1x3 row vector of constant coefficients for the ODE.
%    x_bndry - initial and end points/boundaries in the x-axis.
%    u_bndry - initial and end points/boundaries in the u-axis
%
%    g - this is a function handle for the forcing function g(x)
%
%    n - integer. Number of points (including start and end boundary) we will use.
%
% Return Values
% =============
%    x_out - column vector, of size nx1, of x values (solution to ODE). 
%    u_ out - column vector, of size nx1, of u values (solution to ODE).

function [x_out, u_out] = bvp( c, g, x_bndry, u_bndry, n )
%Argument Checking
    if ~all( size( c ) == [1, 3] ) 
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument c is not a 3-dimensional row vector' ) );
    end
    
    if ~isscalar( n ) || ( n ~= round( n ) ) || n <= 0  
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument n is not a positive integer' ) );
    end
    
    if ~all( size( u_bndry ) == [1,2] ) 
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument u_bndry is not a 2-dimensional row vector' ) );
    end
    
    if ~all( size( x_bndry ) == [1,2] ) 
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument x_bndry is not a 2-dimensional row vector' ) );
    end

    if ~isa( g, 'function_handle' )
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument g is not a function handle' ) );
    end
% Boundary values will be used to determine approximate solutions to a linear ordinary differentia equation. 
%The linear ordinary differential equations represents a line where we aim to find x and u values on the individual line, between the two supplied boundaries.
%
% Parameters
% ==========
%    c -  1x3 row vector of constant coefficients for the ODE.
%    x_bndry - initial and end points/boundaries in the x-axis.
%    u_bndry - initial and end points/boundaries in the u-axis
%
%    g - this is a function handle for the forcing function g(x)
%
%    n - integer. Number of points (including start and end boundary) we will use.
%
% Return Values
% =============
%    x_out - column vector, of size nx1, of x values (solution to ODE). 
%    u_ out - column vector, of size nx1, of u values (solution to ODE).
    %===============================
    %Step 1: Defining the constants
    %===============================
    %This defines the incriments between x-values
    h = (x_bndry(1,2) - x_bndry(1,1))/(n-1) ; 
    % defining the variables used to solve for u-values.
    d_minus = 2*c(1,1) - h*c(1,2);
    d = 2*(h^2)*c(1,3) - 4*c(1,1);
    d_plus = 2*c(1,1) + h*c(1,2);
    %Since we have to solve for u using matrix algebra, I have to
    %initialize the matrices and vectors. This is done in the loop below.
    D = zeros(n-2);
    q = zeros((n-2),1);
    %===================================
    %Step 2: Completing the x_out vector
    %===================================
    % Using a linspace to make the x-values into a column vector
    x_out = linspace(x_bndry(1,1),x_bndry(1,2),n)';
    %===============================================================
    %Step 3: Use loop to set up the matrix and vector and diag to
    %populate D matrix
    %===============================================================
    for i = 1:n-2
        x_i = x_out(i+1);
        q(i,1) = 2*(h^2)*g(x_i);
        % Formation of the n-2 X 1 vector.
        if i == 1
            q(i,1) = 2*(h^2)*g(x_i) - d_minus*u_bndry(1,1);
        end
        if i == n-2
            q(i,1) = 2*(h^2)*g(x_i) - d_plus*u_bndry(1,2);
        end
    end
    D = D + diag(d*ones((n-2),1)) + diag(d_plus*ones((n-3),1),1) + diag(d_minus*ones((n-3),1),-1);
    %==========================================
    %Step 4: Calculate the unknown u_out values
    %==========================================
    %Putting the solution together in a more coherent way.
    u_out = [u_bndry(1,1);D\q;u_bndry(1,2)];
    return;
end
