function [u]=gauss_seidel(f,lambda,par)
% red-black Gauss-Seidel
% Gauss-Seidel sovler for linear equation M*u=f
% where M is a sparse tridiagnal matrix.

if ~exist('par','var')
    par.iter = 100;
    par.plot = 'on';
    par.u0 = f;
end

u0 = par.u0;

% initialization
black = select_pixel(u0,'black');
red = select_pixel(u0,'red');

% alternatingly update red/black
for i = 1:par.iter 
    % update red/black
    red = update_pixel_value(black,f,lambda); % upper left corner of f is red
    black = update_pixel_value(red,f,lambda);
    
    if strcmp(par.plot,'on') % plot option
        black(isnan(black)) = 0;
        red(isnan(red)) = 0;
        u = black + red;
        figure(1), subplot(1,3,3), imshow(u),title(sprintf('denoising %d/%d',i,par.iter))
        black = select_pixel(black,'black');
        red = select_pixel(red,'red');
    end
end

% aggregate result
black(isnan(black)) = 0;
red(isnan(red)) = 0;
u = black + red;

end