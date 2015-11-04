function [gd] = grad(f)
% compute the gradient along the direction, forward gradient and its norm

%% shift-and-substract
f_shift_x = circshift(f,[0,-1]);
f_shift_y = circshift(f,[-1,0]);
f_shift_x(:,end) = 0;
f_shift_y(end,:) = 0;

gd_x = f_shift_x - f;
gd_y = f_shift_y - f;

gd = cell(3,1);
gd{1} = gd_x;
gd{2} = gd_y;

gd{3} = sqrt(gd_x.^2 + gd_y.^2);
end