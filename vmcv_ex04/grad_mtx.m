function fgradMtx = grad_mtx(f, bdy)
% build the gradient matrix (forward difference with Von Neumann boundary condition) of \nabla operator
% \nabla f = (d_x, d_y)' * f
% return gradf is a matrix with dimention 2n*n, n=numel(f)
if ~exist('bdy','var')
    bdy = 'von-neumann';
end
n = numel(f);
[nx,ny] = size(f);

% general gradient matrix
e = ones(n,1);
dy = spdiags([-e e], [0,1], n, n);
dx = spdiags([-e e], [0,nx], n, n);
bdy_ind = [1:nx:n, nx:nx:n, 2:nx-1, n-nx+2:n-1];

% boundary condition
switch bdy
    case 'Neumann' % Von Neumann : u(x)|_{bdy} = fixed knowns
        dx(bdy_ind,:) = 0;
        dy(bdy_ind,:) = 0;
    case 'Dirichlet' % Direchlet : dL/d(\nabla u) = 0
        error('Dirichlet boundary condition need to be implemented.')
    otherwise
        error('malformed boundary condition.')
end

% concadinate gradient operator matrix
fgradMtx = [dx; dy];

end