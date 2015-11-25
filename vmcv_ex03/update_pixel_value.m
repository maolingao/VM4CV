function DummyB = update_pixel_value(DummyR,f,lambda)
% update DummyB by DummyR
% Black and Red are neigbouring pixel mutually

[Ny,Nx]=size(DummyR); 

% shift in each direction by one pixel
DRu = [DummyR(2:Ny,:); zeros(1,Nx)];
DRd = [zeros(1,Nx); DummyR(1:Ny-1,:)];
DRl = [DummyR(:,2:Nx), zeros(Ny,1)];
DRr = [zeros(Ny,1), DummyR(:,1:Nx-1)];

% shift add
DR_sum = DRu + DRl + DRd + DRr;

% update DummyB
f_interior = 1./(1+4*lambda);
DummyB = f_interior * (f + lambda*DR_sum);

% special update correction on the boundary
% edges
f_edge = 1./(1+3*lambda);
DummyB(1,:) = f_edge * (f(1,:) + lambda*DR_sum(1,:));
DummyB(end,:) = f_edge * (f(end,:) + lambda*DR_sum(end,:));
DummyB(:,1) = f_edge * (f(:,1) + lambda*DR_sum(:,1));
DummyB(:,end) = f_edge * (f(:,end) + lambda*DR_sum(:,end));
% corners
f_corner = 1./(1+2*lambda);
DummyB(1,1) = f_corner * (f(1,1) + lambda*DR_sum(1,1));
DummyB(Ny,Nx) = f_corner * (f(Ny,Nx) + lambda*DR_sum(Ny,Nx));
DummyB(1,Nx) = f_corner * (f(1,Nx) + lambda*DR_sum(1,Nx));
DummyB(Ny,1) = f_corner * (f(Ny,1) + lambda*DR_sum(Ny,1));

end