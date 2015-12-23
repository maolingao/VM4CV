function u_uc = upsampling_conj(u, aux)
% conjugate upsample images according to method
% internal function for the class upsampOp.

if ~exist('aux','var')
    aux.method = 'simple';
    aux.tilesize = [2,2];
end

method = aux.method;
tilesize = aux.tilesize;

i_space = tilesize(1); j_space = tilesize(2);
i_stat = i_space; j_stat = j_space;

switch method
    case 'simple'   % sum up the pixel values in each tile to form a new pixel value
                    % do we need to regularize the image ?
        boxFilter = ones(tilesize);
        u_bb = conv2(u, boxFilter,'full'); % box filter (box blur)
        u_uc = u_bb(i_stat:i_space:(end-i_stat+1), j_stat:j_space:(end-j_stat+1)); % to get non-overlap average windows
    otherwise
        error('malformed upsampling_conj method.')
end


end