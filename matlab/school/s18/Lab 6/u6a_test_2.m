%setting up the U_init.
clc
n = 21;
U = -Inf*ones( n, n );
 
for j = 1:n
    for k = 1:n
        x = (j - 1)/(n - 1);
        y = (k - 1)/(n - 1);
        
        r = sqrt( (x - 0.5)^2 + (y - 0.5)^2 );
        
        if r < 0.1
            U(j, k) = 70;
        elseif r >= (n - 1)/(2*n)
            if y <= 0.5
                U(j, k) = 0;
            else
                U(j, k) = NaN;
            end
        end
    end
end

U_steady = laplace2d( U );

t_int_1 = [0,1];
nt_1=14401;
h = 1/(n-1);
kappa = 9;
[t1,u_out_1] = diffusion2d(kappa,h,U_steady,@U6a_bndry,t_int_1,nt_1);
%check = (u_out_1(:,end-1,:) >= 120);
%any(any(check))
