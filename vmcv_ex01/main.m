% general code
%% 2. load img
f = double(imread('coins.png'));
figure(1), subplot(1,2,1), imshow(uint8(f))

%% 3. convolution
sigma = 1;
m = 3; n = 3;
w = psf(m,n,'gaussian',sigma);
% w = psf(m,n,'dirac');

shape = 'same';
y = conv2(f,w,shape);
figure(1), subplot(1,2,2), imshow(uint8(y))

%% 4. img difference

gd = grad(f);
f_grad_x = gd{1};
f_grad_y = gd{2};
figure(2), subplot(1,2,1), imshow(uint8(f_grad_x))
figure(2), subplot(1,2,2), imshow(uint8(f_grad_y))

%% 6. convolution with different sigma
gd_norm = cell(10,1);
length = 3;
for sigma = 1 : length : length*10
m = 3; n = 3;
w = psf(m,n,'gaussian',sigma);
% w = psf(m,n,'dirac');

shape = 'same';
y = conv2(f,w,shape);
gd = grad(y);
gd_norm{ceil(sigma/length)} = gd{3};
figure(3), imshow(uint8(gd_norm{ceil(sigma/length)}))
keyboard
end