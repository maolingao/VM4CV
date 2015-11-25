function x = regular(x)
% regularize image x
% set the range of pixel value within the range of [0,1]

x = x./max(vec(x));
end