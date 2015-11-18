function pard = partialDiffu(M, G, dir)
% calculate the partial diffusion component in the first eqn on chp 2 Diffusion Filtering, slide 13
% d_x(g(|'nabla U|) d_x U)
% input:
% M : current distribution of mass, in our case is the current estimate of ground truth
% G : the diffusity, can be spatial variant or invariant.
% dir : the direction of interest, could be x or y

if ~exist('dir','var')
    dir = 'x';
end

[Ny,Nx]=size(M); 

% calculate one-sided differences
Mn=[M(1,:); M(1:Ny-1,:)]-M; % u_{i,j-1} - u_{i,j}
Ms=[M(2:Ny,:); M(Ny,:)]-M; % u_{i,j+1} - u_{i,j}
Me=[M(:,2:Nx) M(:,Nx)]-M; % u_{i+1,j} - u_{i,j}
Mw=[M(:,1) M(:,1:Nx-1)]-M; % u_{i-1,j} - u_{i,j}

% the interpolated diffusivity
if numel(G) ~= 1
    Gu = [G(2:Ny,:); zeros(1,Nx)];
    Gd = [zeros(1,Nx); G(1:Ny-1,:)];
    Gl = [G(:,2:Nx), zeros(Ny,1)];
    Gr = [zeros(Ny,1), G(:,1:Nx-1)];
    Gxw_semi = sqrt(G.*Gl); % g_{i+1/2,j}
    Gxe_semi = sqrt(G.*Gr); % g_{i-1/2,j}
    Gyn_semi = sqrt(G.*Gu); % g_{i,j+1/2}
    Gys_semi = sqrt(G.*Gd); % g_{i,j-1/2}
else
    Gxw_semi = G*ones(Ny,Nx);
    Gxe_semi = G*ones(Ny,Nx);
    Gyn_semi = G*ones(Ny,Nx);
    Gys_semi = G*ones(Ny,Nx);
    
end
switch dir
    case 'x'
        pard = Gxw_semi.*Me + Gxe_semi.* Mw;
    case 'y'
        pard = Gyn_semi.*Ms + Gys_semi.* Mn;
    otherwise
        error(['Unknown direction "' dir '"']);

end

end