function u_averaged = average(u,aux)
% assign the pixel value in every tile of the img u with the mean value
% of the pixels in that tile.

if ~exist('aux','var')
    aux.method = 'simple';
    aux.tilesize = [2,2];
end

method = aux.method;
tilesize = aux.tilesize; % usize must be integer-multiple of the tilesize, mod(usize,tilesize) == 0.
                         % otherwise the some tiles would have enough
                         % pixels to average.
i_space = tilesize(1); j_space = tilesize(2);
i_stat = i_space; j_stat = j_space;

switch method
    case 'simple'   % replace every pixel in u with 'tilesize' pixels of the same value
        boxFilter = ones(tilesize)./ prod(tilesize);
        u_bb = conv2(u, boxFilter,'full'); % box filter (box blur)
        u_bb_nonoverlap = u_bb(i_stat:i_space:(end-i_stat+1), j_stat:j_space:(end-j_stat+1)); % to get non-overlap average windows
        u_averaged = kron(u_bb_nonoverlap,ones(tilesize));
    otherwise
        error('malformed avarage method.')
end


end