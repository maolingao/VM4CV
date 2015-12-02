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

%
n = numel(u);
lambda = 1; % inverse regularization parameter
bdy = 'Neumann';
fgradMtx = grad_mtx(f, bdy);
flaplacianMtx = -fgradMtx'*fgradMtx;
A = lambda*speye(n) - laplacianMtx;