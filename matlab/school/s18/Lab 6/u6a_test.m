%setting up the U_init.
clc
n = 51;
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

t_int_1 = [0,0.1];
nt_1=1228;
h = (n-0)/(n-1);
k = 0.0000012;



[t1,u_out_1] = diffusion2d(k,h,U_steady,@U6a_bndry,t_int_1,nt_1);


    
%[t2,u_out_2] = diffusion2d(k,h,u_out_1(:,:,end),@U6a_bndry,t_int_2,nt_2);
disp('RIP US');
