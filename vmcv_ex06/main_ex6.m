% ex 6 (super resolution)
% main command file

% ground truth image
u = double(imread('Boat.png'));
usize = size(u);
u = regular(u); 
figure(1), subplot(2,2,1), imshow(u),title('ground truth')

%% super-resolution
% 
load('vmcv_ex06/psf.mat'); % load psf's
for i = 1:10
   f = double(imread(sprintf('boadsbd_%d',i))); 
   
   u = superres_step(A,B,S,U,u,aux);
end