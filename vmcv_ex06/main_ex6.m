% ex 6 (super resolution)
% main command file

% ground truth image
u = double(imread('Boat.png'));
usize = size(u);
u = regular(u); 
figure(1), subplot(2,2,1), imshow(u),title('ground truth')

%% super-resolution
% 
load('vmcv_ex06/psf.mat');      % load psf's
load('vmcv_ex06/shifts.mat');   % load psf's

for i = 1:10
    
   f = double(imread(sprintf('boadsbd_%d.png',i))); % frame to process
   f = regular(f); 
   
   h = h_reg{i}; % blur
   shape = 'same';
   B = conv2MatOp(h, usize, shape);             % operator, blurring;
   
   aux.method = 'simple';                       % for operators: average, upsampling
   aux.tilesize = [2,2];
   aux.bbox = 'same';                           % for operator: shift
   aux.shifts = shift_reg;
   
   S = shiftOp(shift_reg{i}, aux.bbox);         % operator shift
   A = averageOp(aux.tilesize,aux.method);      % operator average
   U = upsampOp(aux.tilesize, aux.method);      % operator upsampling
   
   if i == 1
       aux.uinit = U*f;                             % initial guess of super resolved img
   else
       aux.uinit = u_superres;
   end
   
   u_superres = superres_step(A,B,S,U,f,aux);
   
end