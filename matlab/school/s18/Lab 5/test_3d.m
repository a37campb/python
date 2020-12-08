U4c = -Inf*ones(4,4,4);
U4c(1,:,:) = 1;
U4c(end,:,:) =4;
U4c(:,1,:) = 2;
U4c(:,end,:) = 5;
U4c(:,:,1) =3;
U4c(:,:,end) =6;
U4c_sol = laplace3d(U4c);
isosurf(U4c_sol,21)

