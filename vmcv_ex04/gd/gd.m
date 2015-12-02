function x = gd(fun,grad,x0,aux)
% gradient descent solver
% loss function : argmin_x || AX - I ||^2_F
% fun : loss function handle
% grad : loss function gradient handle
% x0 : initial guess
% aux : cancelation parameters


if ~exist('aux','var'); 
    aux.itr = 100; 
    aux.tol = 1e-6;
end

x = x0;

for k = 1 : aux.itr
    
    r = grad(x);                        % gradient
    p = - r./(norm(r,'fro') + eps);     % gradient descent direction

    alpha = armijo(fun,x,r,p);          % step length - armijo
%   alpha = analyticlineSearch(aux.A,x,p);  % step length - analytic sol
    
    chg = alpha*p;

    x = x + chg;                    % next guess
    assert(fun(x) - fun(x-chg) <= 0, 'ATTENTION : loss funtion is increasing!')
    
    if norm(chg,2) < aux.tol
        sprintf('the number of iterations : %d.', k)
        return
    end
        
end

end