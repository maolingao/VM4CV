function [w] = psf(m,n,varargin)
% generate psf as defined

%% Input parser
P = inputParser;

% List of the optional parameters
P.addOptional('type', 'gaussian', @ischar);
P.addOptional('sigma', 1, @isnumeric);

% read out the Inputs
P.parse(varargin{:});

% Extract the variabls from the Input-Parser
type = P.Results.type;
sigma = P.Results.sigma;

%%
switch type
    case 'gaussian'
        w = gen_psf_gaussian(m,n,sigma);
    case 'dirac'
        w = gen_psf_dirac(m,n);
    otherwise
        error('not define psf type!')
end



end