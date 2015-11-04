function w = gen_psf_dirac(m,n)
% generat dirac matrix as psf

w = zeros(m,n);
mid_ind = median(m);
w(mid_ind,mid_ind) = 1;

end