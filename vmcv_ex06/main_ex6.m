% ex 6
% main command file

% ground truth image
u = double(imread('Boat.png'));
usize = size(u);
u = regular(u); 
figure(1), subplot(2,2,1), imshow(u),title('ground truth')

%% preparing input sequential imgs
% warpping (shift) -> downsampling -> blur (gaussian kernel)
% warpping

xs = imshift(x, t, bbox)