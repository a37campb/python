%setting up the U_init.
clear all
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

U_steady = laplace2d( U6a_bndry(100,n,n) );

t_int_1 = [0,1];
nt_1=2722;
h = 1/(n-1);
kappa = 1.698879999999993;

a =0;
while a == 0
    [t1,u_out_1] = diffusion2d(kappa,h,U_steady,@U6a_bndry,t_int_1,nt_1);
    kappa = kappa-0.00001;
    if any(any(u_out_1(:,end-1,:) >= 120))
        nt_1 = ceil((4*kappa*(t_int_1(2)-t_int_1(1)))/(h^2) + 1)+1;
        a =0;
    else
        a=1;
        break
    end
end

disp(kappa);