function [u] = superres_step(A,B,S,U,f,aux)
% super resolution for one frame

method = aux.method;               % for operators: average, upsamp
tilesize = aux.tilesize;
bbox = aux.bbox;                   % for operator: imshift
shifts = aux.shifts;
uinit = aux.uinit;                 % initial guess of super resolved img

shift = shifts{1};
imshow(S(uinit, shift, bbox));

end