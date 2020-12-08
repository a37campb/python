c = 3;
for n = 3:20
   U = -Inf*ones(51,51,n); 
   U(:,:,1) = 0;
   U(:,:,end) = NaN;
   U(16:36,16:36,end) = 5;
   U(1,:,2:end) = NaN;
   U(end,:,2:end) = NaN;
   U(:,1,2:end) = NaN;
   U(:,end,2:end) = NaN;
   U_out = laplace3d(U);
   if max( max( U_out(11, :, :) ) ) <= 1 && max( max( U_out(41, :, :) ) ) <= 1 && max( max( U_out(:, 11, :) ) ) <= 1 && max( max( U_out(:, 41, :) ) ) <= 1 
       c = n; 
   end
end