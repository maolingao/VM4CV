% general code
%% 2. load img
f = double(imread('coins.png'));
figure(1), subplot(1,2,1), imshow(uint8(f))

%% 3. convolution
sigma = 1;
m = 3; n = 3;
w = psf(m,n,'gaussian',sigma);
w = psf(m,n,'dirac');

shape = 'same';
keyboard
y = conv2(f,w,shape);
figure(1), subplot(1,2,2), imshow(uint8(y))

