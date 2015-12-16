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
load('vmcv_ex06/shifts.mat'); % load psf's

for i = 1:10
    
   f = double(imread(sprintf('boadsbd_%d.png',i))); % frame to process
   
   h = h_reg{i}; % blur
   shape = 'same';
   B = conv2MatOp(h, usize, shape);     % operator, blurring;
   
   A = @average;                        % operator, average(u,tilesize,'average');
   S = @imshift;                        % operator, imshift(u, shift, bbox);
   U = @upsamp;                         % operator, upsamp(f,tilesize,'average');
   
   aux.method = 'average';              % for operators: average, upsamp
   aux.tilesize = [2,2];
   aux.bbox = 'same';                   % for operator: imshift
   aux.shifts = shift_reg;

   u = superres_step(A,B,S,U,u,aux);
   
end