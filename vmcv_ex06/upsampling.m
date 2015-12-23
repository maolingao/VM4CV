function u_upsampled = upsampling(u, aux)
% upsample images according to method

if ~exist('aux','var')
    aux.method = 'simple';
    aux.tilesize = [2,2];
end

method = aux.method;
tilesize = aux.tilesize;


switch method
    case 'simple'   % replace every pixel in u with 'tilesize' pixels of the same value
        u_upsampled = kron(u,ones(tilesize));
    otherwise
        error('malformed upsampling method.')
end


end