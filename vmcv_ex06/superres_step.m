function [u] = superres_step(A,B,S,U,f,aux)
% super resolution for one frame

method = aux.method;               % for operators: average, upsamp
tilesize = aux.tilesize;
bbox = aux.bbox;                   % for operator: imshift
shifts = aux.shifts;
uinit = aux.uinit;                 % initial guess of super resolved img

% shift = shifts{1};
% imshow(S(uinit, shift, bbox));

% solver - gradient descent
% cancellation criteria
aux.itr = 1e3;          % iteration limit
aux.tol = 1e-6;         % smallest update of estimate
epsilon = 1e-6;         % for numerical stable

bdy = 'Neumann';
fgradMtx = grad_mtx(f, bdy);    % gradient operator corresponds dim of f
div = -fgradMtx';       % div = - \nabla^T

% gradient descent solver
x0 = uinit;         % initial guess
fun = @(x)(norm(A(B*S(x)) - U(f),'fro') + sum(vec(abs(select(grad(x),3)))));    % loss
d_grad = @(x)(2*S(B(A(A(B(S()))))));
d_grad = @(x)(lambda*(x-f) - reshape(div*(fgradMtx*vec(x)./(abs(fgradMtx*vec(x))+epsilon)),size(f)));                       % gradient of loss

u = gd(fun,d_grad,x0,aux);                     % gradient descent solver


figure(1), subplot(2,2,4), imshow(u_denoised_l1),title('denoised version - L1(ROF)')
end