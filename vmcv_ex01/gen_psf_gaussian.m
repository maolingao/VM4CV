function w = gen_psf_gaussian(m,n,sigma)
% generate gaussian psf
%%
w = zeros(m,n);
den = 2*sigma^2;
mid_ind = median([1:m]);
for i = 1 : m
    for j = 1 : i
        w(i,j) = exp(-( ((i-mid_ind))^2 + ((j-mid_ind))^2) / den);
    end
end

mask = diag(ones(m,1));
mask = (mask==0);
w_sym = w'.*mask;
w = w + w_sym;

w = normalize(w); % energy preserve
end