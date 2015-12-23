% ex 4
% main command file

% ground truth image
u = double(imread('lena.pgm'));
xsize = size(u);
u = regular(u); 
figure(1), subplot(2,2,1), imshow(u),title('ground truth')

% add noise
SNR = 10;
f = addnoise(u,SNR,u);
figure(1), subplot(2,2,2), imshow(f),title(sprintf('noisy %d dB',SNR))

%% ex4.2 denoising with L2 regularization
% build up the linear denoising eqn lambda*(u-f) - laplacian*u = 0
% equivalently solving the linear eqn ->  (lambda - laplacian)*u = lambda*f
% def matrix A = (lambda - laplacian)
n = numel(f);
lambda = 1e-2; % ##inverse## of the usually regularization parameter
bdy = 'Neumann';
fgradMtx = grad_mtx(f, bdy);    % gradient operator corresponds dim of f
flaplacianMtx = -fgradMtx'*fgradMtx; % laplacian operator corresponds dim of f 
                                     % laplacian = div nabla =
                                     % = -nabla^T * nabla (see ex sheet)
A = lambda*speye(n) - flaplacianMtx; % matrix A of the linear eqn above.

u_denoised_l2_vec = A\(lambda*vec(f)); % solve the eqn using \

u_denoised_l2 = reshape(u_denoised_l2_vec, size(f)); % reshape and plot
figure(1), subplot(2,2,3), imshow(u_denoised_l2),title('denoised version - L2')

%% ex4.3 denoising with L1 regularization 
% Rudin-Osher-Fatemi(ROF) functional
% solver - gradient descent
% cancellation criteria
aux.itr = 1e3;          % iteration limit
aux.tol = 1e-6;         % smallest update of estimate
epsilon = 1e-6;         % for numerical stable
div = -fgradMtx';       % div = - \nabla^T

% gradient descent solver
x0 = f;         % initial guess
fun = @(x)(lambda/2*norm((x-f),'fro')^2 + sum(vec(abs(select(grad(x),3)))));    % loss
d_grad = @(x)(lambda*(x-f) - reshape(div*(fgradMtx*vec(x)./(abs(fgradMtx*vec(x))+epsilon)),size(f)));                       % gradient of loss


figure(1), subplot(2,2,4)
u_denoised_l1 = gd(fun,d_grad,x0,aux);                     % gradient descent solver


figure(1), subplot(2,2,4), imshow(u_denoised_l1),title('denoised version - L1(ROF)')

% check sol 
% diff_l1 = norm(u_denoised_l1 - u)
% diff_l2 = norm(u_denoised_l2 - u)


