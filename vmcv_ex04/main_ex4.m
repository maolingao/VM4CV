% ex 4
% main command file

% ground truth image
u = double(imread('lena.pgm'));
xsize = size(u);
u = regular(u); 
figure(1), subplot(1,3,1), imshow(u),title('ground truth')

% add noise
SNR = 10;
f = addnoise(u,SNR,u);
figure(1), subplot(1,3,2), imshow(f),title(sprintf('noisy %d dB',SNR))

%% ex4.2 denoising with L2 regularization
% build up the linear denoising eqn lambda*(u-f) - laplacian*u = 0
% equivalently solving the linear eqn ->  (lambda - laplacian)*u = lambda*f
% def matrix A = (lambda - laplacian)
n = numel(f);
lambda = 1e0; % inverse regularization parameter
bdy = 'Neumann';
fgradMtx = grad_mtx(f, bdy);    % gradient operator corresponds dim of f
flaplacianMtx = -fgradMtx'*fgradMtx; % laplacian operator corresponds dim of f
A = lambda*speye(n) - flaplacianMtx; % matrix A of the linear eqn above.

u_denoised_l2_vec = A\(lambda*vec(f));
u_denoised_l2 = reshape(u_denoised_l2_vec, size(f));
figure(1), subplot(1,3,3), imshow(u_denoised_l2),title('denoised version - L2')

%% ex4.3 denoising with L1 regularization 
% Rudin-Osher-Fatemi(ROF) functional


