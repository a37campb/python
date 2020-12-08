%laplace3d

% The laplace equation is a second order partial differential in all
% spaces, that yields zero. This function's purpose is to approximate the
% solution to the Laplace equation within three dimensions. This function is
% powerful enough to handle asymmetric scenarios. 

%Parameter
%==========

% U - A two dimensional matrix containing the boundry conditions, the point
%s to be solved (marked by -Inf) and any potential insulation (marked by
%NAN).

function [u_out ] = laplace3d( U )

    %%============================
    % 1. Error & Argument Checking
    %%============================

    if ~(ndims(U) == 3)
        thow( MException('MATLAB:invalid_argument',...
            'the argument U is not a 3-dimensional matrix') );
    end

    if any(any(isinf(U(1,:,:)))) | any(any(isinf(U(end,:,:)))) | any(any(isinf(U(:,1,:)))) | any(any(isinf(U(:,end,:)))) | any(any(isinf(U(:,:,1)))) | any(any(isinf(U(:,:,end))))
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument U is of invalid nature -- has a -Inf on the outer boundary of the mesh.' ) );
    end
    
    %%=====================================
    % 2. Initialization of the u_out matrix
    %%=====================================
    [nx,ny,nz] = size(U);
    u_out = U; %initally set this as u_out to later append
    
    %%==================================================
    % 3. Associate each -Inf with an integer from 1 to m
    %%==================================================
    u_to_w = zeros( nx, ny, nz );
    w_to_u = zeros( 3, nx * ny * nz );
    m = 0;
    for ix = 1:nx
        for iy = 1:ny
            for iz = 1:nz
                if U(ix, iy, iz) == -Inf
                    m = m + 1; %counting the number of points to be solved.
                    u_to_w(ix, iy, iz) = m; 
                    w_to_u(:, m) = [ix, iy, iz]'; %matrix containing positions of points to be solved for
                end
            end
        end
    end
    
    %%===================================================
    % 4. Creating the System of Linear Equations to solve
    %%===================================================
    
    M = spalloc( m, m, 7*m ); % to be updated over time
    %M = zeros(m,m); %empty matrix to be filled with coefficients of the approximation method
    b = zeros( m, 1 ); % vector of known boundary conditions. updated over time
    
    for k = 1:m
        % Get the coordinates of the kth point
        % For each of the 4 (6 for 3D) adjacent points, determine if the point is
        % an insluated boundary point, a Dirichlet boundary point or an unknown
        % value and modify M as appropriate.
        c = w_to_u(:,k); 
        % Ca runs from left, bottom, back, front, top then right.
        for Ca = [-1 0 0 0 0 1;0 -1 0 0 1 0;0 0 -1 1 0 0]
            p = c + Ca;
            % Insulated Position
            %====================
            if isnan(U(p(1),p(2),p(3)))
                continue % doing nothing
            % -INF Position
            %===============
            elseif isinf(U(p(1),p(2),p(3))) %updating M accordingly
                M(k,u_to_w(p(1),p(2),p(3))) = M(k,u_to_w(p(1),p(2),p(3))) + 1;
                M(k,k) = M(k,k) - 1;
            % Dirchlet Boundary Condition
            %=============================
            elseif ~isnan(U(p(1),p(2),p(3))) | ~isinf(U(p(1),p(2),p(3))) %updating M accordingly
                b(k) = b(k) - U(p(1),p(2),p(3));
                M(k,k) = M(k,k) - 1; 
            end
        end
    end
    
    % Solving for the unknown points in the Mesh
    %===========================================
    w = M \ b; % Using Linear Algebra to solve for the unknown points
    
    %%====================================
    % 5. Copying these values into u_out
    %%====================================
    
    for k = 1:m
        % Copy the value from w into U_out
        pos = w_to_u(:,k);
        u_out(pos(1),pos(2),pos(3)) = w(k);
    end

end
