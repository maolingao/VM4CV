% ex 6 (super resolution)
% main command file

% ground truth image
u = double(imread('Boat.png'));
usize = size(u);
u = regular(u); 
figure(1), subplot(2,2,1), imshow(u),title('ground truth')

%% preparing input sequential imgs
% warpping (shift) -> downsampling -> blur (gaussian kernel)

for i = 1 : 10
% warpping (shift)
shift = [0,i];
bbox = 'same';
us = imshift(u, shift, bbox); % shift the original image

% blurring (gaussian kernel with size n*n)
m = 5; n = 10; sigma = 3; 
fsize = [m,n];
f = fspecial('gaussian', fsize, sigma); % psf

shape = 'same';
F = conv2MatOp(f, usize, shape); 
usb = F*us; % blurring shifted image

% downsampling (by factor 2, using nearest neighbor interpolation)
df = 1/2; % downsampling factor
method = 'nearest'; % method to assign pixel value to downsampled img
usbd = imresize(usb, df, method); % downsampling the blurred, shifted image
imwrite(usbd,sprintf('vmcv_ex06/boadsbd_%d.png',i));

% plot
% figure(1), 
% subplot(1,4,1); imshow(u),title('original')
% subplot(1,4,2); imshow(us),title('shifted')
% subplot(1,4,3); imshow(usb),title('blurred, shifted')
% subplot(1,4,4); imshow(usbd),title('downsampled, blurred, shifted')
end

%% super-resolution