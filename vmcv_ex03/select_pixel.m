function x = select_pixel(f,blk)
% select Black or Red pixel from f
% the values of rest pixels will be set to nan.
if ~exist('blk','var')
    blk = 'red';
end

[j,i] = meshgrid(1:size(f,1),1:size(f,2)); % i-row, j-column
mask = mod((i + j),2); % mask with 0/1 to indicate red/black

switch blk
    case 'red' % red starts with the upper left corner.
        mask(mask==1) = nan;
        mask(mask==0) = 1;
        x = f.*mask;
    case 'black'
        mask(mask==0) = nan;
        x = f.*mask;
    otherwise
        error('malformed pixel indicator.')
end

end