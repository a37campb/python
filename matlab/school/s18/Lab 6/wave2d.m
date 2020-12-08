% wave2d
% Approximating the solution to the wave and diffusion equation in higher 
% dimensions makes use of initial conditions being provided as a matrix. 
% The change from iteration one to two is also provided as a matrix. The 
% inner values are determined based upon center space center time 
% approximations, making use of boundary condition. Unknown points
% (interior) are marked with -Inf, insulated boundaries (on the 
% edges)are marked with NaN,  while Dirichlet boundary conditions are 
% marked by integers. Depending on the neighbours of the point being solved
% for the point is approximated in different ways. 
%
% Parameters
% ==========
%    c - This outlines the speed of the wave, as it moves through the
%    medium. For the purposes of the code, it must be a scalar value.
%    t_int - This is the row vector detailing the time for which the 
%    function is being approximated for.
%
%    u_init - This is a [nx, ny] matrix containing the initial conditions 
%    for both x and y, at t=0.
%
%    du_init - This is a [nx,ny] matrix containing the initial changes in 
%    boundary conditions of the system from iteration one to iteration two.
%    This is required as the method of approximation being used for the 
%    remainder of the code, requires this term to be known. 
%
%    u_bndry - This is a function handle for the boundaries of the shape,
%    which inputs a time, and outputs the solution of U for that time. 
%
%    h - This is a constant stepping value which dictates the amount of 
%    step between our values in each dimension. We assume this value to be
%    constant. 
%
%    nt - This is an integer to determine the number of times we will 
%    divide the interval t_int into. Also defines the number of 3rd 
%    dimensions for our final array.
%
% Return Values
% =============
%    t - The vector t is a 1 by nt vector which indicates all the time 
%    increments used in the approximation. 
%    u_out - The matrix u_out is either a 3D matrix containing the values
%    of temperature changing with time and in all dimensions.

function [t, u_out] = wave2d( c, h, u_init, du_init, u_bndry, t_int, nt )
    %Argument Checking
    
    %==========================
    %ERROR AND WARNING CHECKING
    %==========================
    if ~isscalar( c ) 
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument c is not a scalar' ) );
    end
    
    if ~isscalar( h ) 
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument h is not a scalar' ) );
    end
    
    if ~ismatrix( u_init ) || ~ismatrix( du_init )
        throw( MException( 'MATLAB:invalid_argument', ...
        'the atleast one of the arguments u_init and', ...
        ' du_init is not a matrix' ) );
    end
    
    if ~( size( u_init ) == size( du_init ) )
        throw( MException( 'MATLAB:invalid_argument', ...
        'the matrices u_init and du_init are of incorrect dimensions' ) );
    end
    
    if any(isinf(u_init(1,:))) | any(isinf(u_init(end,:))) | any(isinf(u_init(:,1))) | any(isinf(u_init(:,end)))
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument u_init is of invalid nature -- has a -Inf on the outer boundary of the mesh.' ) );
    end
    
    if any(isinf(du_init(1,:))) | any(isinf(du_init(end,:))) | any(isinf(du_init(:,1))) | any(isinf(du_init(:,end)))
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument du_init is of invalid nature -- has a -Inf on the outer boundary of the mesh.' ) );
    end
    
    if ~isa( u_bndry, 'function_handle' )
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument u_bndry is not a a function handle' ) );
    end
    
    if ~all( size( t_int ) == [1, 2] ) 
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument t_int is not a 2-dimensional row vector' ) );
    end
    
    if ~isscalar( nt ) || ( nt ~= round( nt ) ) || (nt < 0)   
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument nt is not a positive integer' ) );
    end  
    
    %==============
    %INITIALIZATION
    %==============
    dt = (t_int(2) - t_int(1))/(nt - 1);
    % Simplifying the constant for solving to a single variable.
    r = (c*dt/h)^2;
    
    if r >= 1/4 
        new_nt = ceil((sqrt(4)*c*(t_int(2)-t_int(1)))/h + 1) ;
        throw( MException( 'MATLAB:invalid_argument', ...
            'the value of r,%g, >= 1/6 and is too large for convergence', ...
            ' try %g as the value of nt.',r,new_nt ) );
    end
    
    t = linspace( t_int(1), t_int(2), nt );
    
    %Grabbing values of nx and ny to form u_out.
    [nx, ny] = size( u_init );
    u_out = zeros( nx, ny, nt );
    %Setting the first time iteration to the initial conditions.
    u_out(:, :, 1) = u_init;
    % Solving for the second time step given du_init.
    u_out(:, :, 2) = u_out(:, :, 1) + dt*du_init;
    
    %=======
    %SOLVING
    %=======
    for it = 3:nt
        u_out(:, :, it) = u_bndry( t(it), nx, ny );
        %To solve, we need to iterate through each x and y value for this
        %time step.
        for ix = 1:nx
            for iy = 1:ny
                if u_out(ix, iy, it) == -Inf
                    Utmp = u_out(ix, iy, it - 1);
                    u_out(ix, iy, it) = 2*Utmp - u_out(ix, iy, it - 2);
                    
                    for pos = [-1 1 0 0; 0 0 -1 1]
                        dix = ix + pos(1);
                        diy = iy + pos(2);

                        if ~isnan( u_out(dix, diy, it - 1) )
                            u_out(ix, iy, it) = u_out(ix, iy, it) + ...
                                r*( u_out(dix, diy, it - 1) - Utmp );
                        end
                    end
                end
            end
        end
    end

end