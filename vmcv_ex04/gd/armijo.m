function alpha = armijo(fun,x,r,p,par)
% line-search : armijo condition (backtracking)

if ~exist('par','var')
    par.c = 0.5;
    par.rho = 0.5;
    par.alpha0 = 1;
end

% paremeter to be tuned
c = par.c;
rho = par.rho;
alpha0 = par.alpha0;

% initial settings
alpha   = alpha0;
diff    = 1;                        % initial diff, ensure stepping into the loop
f_x     = fun(x);                   % loss function value @ x
crp     = c * trace(p'*r);          % reg : change of unit step size in direction p 

while diff > 0                      % cancel if change is not sufficient
    
    f_func  = fun(x+alpha*p);       % loss function value
    f_cord  = f_x + alpha * crp;    % cord line value
    diff    = f_func - f_cord;      % compare 
    
    if diff > 0
        alpha   = alpha * rho;
    end
end

end