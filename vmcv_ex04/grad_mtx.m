function fgradMtx = grad_mtx(f, bdy)
% build the gradient matrix (forward difference with Von Neumann boundary condition) of \nabla operator
% \nabla f = (d_x, d_y)' * f
% return gradf is a matrix with dimention 2n*n, n=numel(f)
if ~exist('bdy','var')
    bdy = 'Null';
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
    case 'Null' % Direchlet : u(x)|_{bdy} = fixed knowns
        warning('No boundary condition assigned.')
    case 'Neumann' % Von Neumann : dL/d(\nabla u) = 0
        dx(bdy_ind,:) = 0;
        dy(bdy_ind,:) = 0;
    case 'Dirichlet' % Direchlet : u(x)|_{bdy} = fixed knowns
        error('Dirichlet boundary condition need to be implemented.')
    otherwise
        error('malformed boundary condition.')
end

% concadinate gradient operator matrix
fgradMtx = [dx; dy];

end

%% unittest
%{
f = double(imread('eight.tif'));
[fx,fy] = size(f);
n = numel(f);
f = regular(f);

% using gradient matrix
fgradMtx = grad_mtx(f, 'Null'); % gradient matrix w.r.t. f
gradf = fgradMtx*vec(f);        % gradient of f

gradf_x = reshape(gradf(1:n),[fx,fy]);  % gradient of f in x direction
gradf_y = reshape(gradf(n+1:end),[fx,fy]); % gradient of f in y direction

figure(1), subplot(2,2,1), imshow(gradf_x); title('\nabla f_x'); ylabel('gradiet mtx'); 
           subplot(2,2,2), imshow(gradf_y), title('\nabla f_y'); 

% using the finite differences
[gd] = grad(f);
gradf_x_fd = gd{1};
gradf_y_fd = gd{2};

figure(1), subplot(2,2,3), imshow(gradf_x_fd); ylabel('finit differences');
           subplot(2,2,4), imshow(gradf_y_fd), 

% check the error btw two methods
max(vec(gradf_x_fd - gradf_x))
max(vec(gradf_y_fd - gradf_y))
%}