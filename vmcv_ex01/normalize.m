function w_normed = normalize(w)
% normalize w, ensure the sum of all entries to 1

den = sum(w(:));

w_normed = w./den;

end