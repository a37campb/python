%richarson22
%
%The Richarrdson’s extrapolation is used to eliminate higher order errors with approximations of derivatives. This extrapolation is useful as there is no subtractive cancellation.
%
% Parameters
% ==========
%    D - The derivative of the function u with respect to x, using either centered, 1st derivative, 2nd 
%        order centered differences or backward differences.
%    u - a function of the real value x.
%
%    x - variable of the function u.
%    h - the small change in x.
%
%    N_max - max iteratins; indication to the size of a zero matrix  (NMAX + 1) X (NMAX + 1)
%    eps_abs - the absolute error of the result.
%
% Return Value
% ============
%    du - the derivative of the function u at a value x.

function [du] = richardson22( D, u, x, h, N_max, eps_abs )
    if ~isscalar( N_max )  || (N_max ~= round( N_max )) || (N_max <= 0) 
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument N_max is not a scalar' ) );
    end

    if ~isscalar( eps_abs ) || (eps_abs <= 0) 
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument eps_abs is not a positive scalar' ) );
    end

    if ~isscalar( x )  
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument x is not an integer' ) );
    end

    if ~isscalar(h)
        throw( MException( 'MATLAB:invalid argument',...
        'the argument h is not a scalar'));
    end

    if ~isa( D, 'function_handle' )
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument D is not a function handle' ) );
    end
    
    if ~isa( u, 'function_handle' )
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument u is not a function handle' ) );
    end


    %{
        Explanation of Richardson Extrapolation:
        The function will fill a matrix, initially of zeros, with the
        R_(x,y) such that only the lower half of the matrix using a given
        differentiation method.
        The function determines the (1,1) value of the matrix,, the
        uses a loop 
    %}
    R = zeros(N_max + 1,N_max + 1);
    R(1,1) = D(u,x,h);
    for i=1:N_max
        R(i+1,1) = D(u,x,(h/(2^i)));
        for j=1:i
           R(i+1,j+1) = ( (4^j)*R(i+1,j) - R(i,j) )/( (4^j) - 1 );
        end
        if abs( R(i+1,i+1) - R(i,i) ) < eps_abs
            du = R(i+1,i+1);
            return;
        end
    end
    throw(MException('MATLAB:numeric_exception','Richardson Extrapolation did not converge.')); %Outputs a detailed error, explaining why the function failed.
end

