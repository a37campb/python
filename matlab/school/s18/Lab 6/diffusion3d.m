%diffusion3d

% This function is meant to approximate the solution to the 3D diffusion
% equation using center space center time approximations. 

%Parameters
%==========
%   k - this is a diffusivity constant. This code takes it as a scalar.
%   h - This is a step between each of the concurrent points in each
%   dimension (including time)
%   u_init - This is a matrix containing the initial conditions for the
%   scheme. This will be a 3D matrix of size nx by ny by nz
%   u_bndry - This is a function handle that accepts t, x, y and z to output
%   a matrix of size u_init
%   t_int - This is a row vector that specifies the start and end times
%   being considered for this approximation. 
%   nt - This is a scalar value which defines the number of steps being
%   taken in t_int. 

% Return Values
%==============
%   t - This is a row vector specifying the values of time used in the
%   approximation. 
%   u_out - This is a 4D array of nx,ny,nz and nt. This contains the
%   approximated solutions to the diffusion equation for each position in
%   time.

function [t, u_out] = diffusion3d( k, h, u_init, u_bndry, t_int, nt )
% Argument Checking

    if ~isscalar( k ) 
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument k is not a scalar' ) );
    end
    
    if ~isscalar( h ) 
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument h is not a scalar' ) );
    end
    
    if ~(ndims( u_init ) == 3)
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument u_init is not a 3D array' ) );
    end
    
     if ~isa( u_bndry, 'function_handle' )
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument u_bndry is not a function handle' ) );
    end
    
    if ~all( size( t_int ) == [1, 2] ) 
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument t_int is not a 2-dimensional row vector' ) );
    end
    
    if ~isscalar( nt ) || ( nt ~= round( nt ) ) || (nt < 0)   
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument nt is not a positive integer' ) );
    end
    
    dt = (t_int(2) - t_int(1))/(nt - 1);
    r = k*dt/h^2;
    
    if r >= 1/6 
        new_nt = ceil((6*k*(t_int(2)-t_int(1)))/(h^2) + 1) ;
        throw( MException( 'MATLAB:invalid_argument', ...
            'the value of r (being %g) >= 1/6 and is too large for',...
            ' convergence try %g as the value of nt.',r, new_nt ) );
    end
    
    t = linspace( t_int(1), t_int(2), nt );
 
    [nx, ny, nz] = size( u_init );
 
    u_out = zeros( nx, ny, nz, nt );
    u_out(:, :, :, 1) = u_init;
    
    for it = 2:nt
        u_out(:, :, :, it) = u_bndry( t(it), nx, ny, nz );
        
        for ix = 1:nx
            for iy = 1:ny
                for iz = 1:nz
                    if u_out(ix, iy, iz, it) == -Inf
                        Utmp = u_out(ix, iy, iz, it - 1);
                        u_out(ix, iy, iz, it) = Utmp;

                        for pos = [-1 1 0 0 0 0; 0 0 -1 1 0 0; 0 0 0 0 -1 1]
                            dix = ix + pos(1);
                            diy = iy + pos(2);
                            diz = iz + pos(3);

                            if ~isnan( u_out(dix, diy, diz, it - 1) )
                                u_out(ix, iy, iz, it) = u_out(ix, iy, iz, it) + ...
                                    r*( u_out(dix, diy, diz, it - 1) - Utmp );
                            end
                        end
                    end
                end
            end
        end
    end

end
