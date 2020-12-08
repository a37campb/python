clc
clear

n = 21;
c_bath = 1;
U6b_init = zeros( n, n, n );
U6b_init(:, :, [1, end]) = c_bath;
 
for i = 1:n
    for j = 1:n
        for k = 1:n
            x = (i - 1)/(n - 1);
            y = (j - 1)/(n - 1);
        
            r = sqrt( (x - 0.5)^2 + (y - 0.5)^2 );
        
            if r >= 0.5
                U6b_init(i, j, k) = 1;
            end
        end
    end
end

T_final = 20;
n_t = 500;
[t, U6b_out] = diffusion3d( 4, 1, U6b_init, @u6b_bndry, [0, T_final], n_t );
c_max = zeros( 1, n_t );
c_min = zeros( 1, n_t );

for k = 1:n_t
    c_max(k) = max( max( max( U6b_out(:, :, :, k) ) ) );
    c_min(k) = min( min( min( U6b_out(:, :, :, k) ) ) );
end

delta = max(abs(c_max(end)-1),abs(c_min(end)-1))
grade = 10 - T_final - log2( delta )
plot( t, c_max );hold on;plot( t, c_min );
