% ex 2
% main command file
%% separable convolution of Gaussian kernel
% ground truth image
x = double(imread('lena.pgm'));
xsize = size(x);
figure(1), subplot(2,3,1), imshow(uint8(x)),title('ground truth')
% psf
m = 5; n = 10; sigma = 3;
fsize = [m,n];
f = fspecial('gaussian', fsize, sigma);
fx = fspecial('gaussian', [m,1], sigma);
fy = fspecial('gaussian', [1,n], sigma);
% convolution operator
shape = 'same';
F = conv2MatOp(f, xsize, shape);
Fx = conv2MatOp(fx, xsize, shape);
Fy = conv2MatOp(fy, xsize, shape);

y_blur = F*x;
y_x_blur = Fx*x;
y_y_blur = Fy*x;
y_xy_blur = Fy*y_x_blur;
figure(1), subplot(2,3,2),imshow(uint8(y_blur)), title('direct gaussian blur')
figure(1), subplot(2,3,4),imshow(uint8(y_x_blur)),title('blur x')
figure(1), subplot(2,3,5),imshow(uint8(y_y_blur)),title('blur y')
figure(1), subplot(2,3,6),imshow(uint8(y_xy_blur)),title('separable gaussian blur')

diff_blur = y_xy_blur - y_blur;
sprintf('the max of absolute difference btw direct and separable gaussian blur is %d', max(abs(diff_blur(:))))

%% diffusion