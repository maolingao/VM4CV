% ex 3
% main command file
%% 
% ground truth image
u = double(imread('lena.pgm'));
xsize = size(u);
u = u./max(vec(u));
figure(1), subplot(1,3,1), imshow(u),title('ground truth')

% add noise
SNR = 10;
f = addnoise(u,SNR,u);
figure(1), subplot(1,3,2), imshow(f),title(sprintf('noisy %d dB',SNR))
lambda = 1e0; % regularization parameter

% call gauss_seidel solver
par.iter = 1e2; par.plot = 'on'; 
par.u0 = zeros(xsize); % arbitrary initialization, it will converge, due to convexity of the cost function.
[u]=gauss_seidel(f,lambda,par);

% visualize denoising result
u_denoised = reshape(u,size(u));
figure(1), subplot(1,3,3), imshow(u_denoised),title('denoised version')