function [u_superres] = superres_step(A,B,S,U,f,aux)
% super resolution for one frame

uinit = aux.uinit;                 % initial guess of super resolved img
lambda = 1e-2;

% solver - gradient descent
% cancellation criteria
aux.itr = 1e3;          % iteration limit
aux.tol = 1e-6;         % smallest update of estimate
epsilon = 1e-6;         % for numerical stable

bdy = 'Neumann';
fgradMtx = grad_mtx(uinit, bdy);    % gradient operator corresponds dim of uinit
div = -fgradMtx';       % div = - \nabla^T

% gradient descent solver
x0 = uinit;         % initial guess
fun = @(x)(norm(A*(B*(S*x)) - U*f,'fro') + lambda * sum(vec(abs(select(grad(x),3)))));    % loss
d_grad = @(x)(2*(S'*(B'*(A'*(A*(B*(S*x)))))) - S'*(B'*(A'*(U*f))) - ...
    lambda* reshape(div*(fgradMtx*vec(x)./(abs(fgradMtx*vec(x))+epsilon)),size(uinit)));      % gradient of loss

u_superres = gd(fun,d_grad,x0,aux);                     % gradient descent solver


figure(1), subplot(2,2,4), imshow(u_superres),title('super-resolved version - L1(ROF)')
end