function [u] = superres_step(A,B,S,U,u_init,aux)
% super resolution for one frame

method = aux.method;               % for operators: average, upsamp
tilesize = aux.tilesize;
bbox = aux.bbox;                   % for operator: imshift
shifts = aux.shifts;

shift = shifts{1};
imshow(S(u, shift, bbox));

end