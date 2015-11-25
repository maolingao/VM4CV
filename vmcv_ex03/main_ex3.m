% ex 3
% main command file
%% 
% ground truth image
x = double(imread('lena.pgm'));
xsize = size(x);
figure(1), subplot(2,2,1), imshow(uint8(x)),title('ground truth')
n = numel(x);

% prepare linear system M
lambda = 1e-2; % regularization parameter
diagn = (1+2*lambda) * ones(n,1);   % non-zero entries
diagn(1) = 1+lambda; diagn(end) = 1+lambda;
diagnOffUp = (-lambda) * ones(n-1,1);
diagnOffDown = (-lambda) * ones(n-1,1);
entries = [diagnOffUp; diagn; diagnOffDown];

indi = [(1:n-1)';(1:n)';(2:n)']; % index of non-zero entries
indj = [(2:n)'; (1:n)';(1:n-1)'];

M = sparse(indi,indj,entries); % a large sparse tridiagonal matrix

% call gauss_seidel solver
u = gauss_seidel(M,x); % x is right hand side of linear equation M*x = b

% visualize denoising result
u_denoised = reshape(u,size(x));
figure(1), subplot(2,2,1), imshow(uint8(u_denoised)),title('denoised version')