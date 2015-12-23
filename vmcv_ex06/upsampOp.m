classdef upsampOp < handle
    % Upsampling Operator Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        tilesize       % each pixel will expan to the size of each tile/block
        method         % internal method of the function upsamling/upsamling_conj
        flag           % flag for upsampling or conjugate upsampling
    end
    
    methods
        % methods, including the constructor are defined in this block
        
        function obj = upsampOp(tilesize,method)
            % class constructor
            if(nargin > 0)     
                obj.tilesize = tilesize;
                obj.method = method;
            end
            obj.flag = 0;
        end
       
       function outp = mtimes(obj,x)
                % x_u         % upsampled image
                % x_conj_u    % conjugate upsampled image
           switch obj.flag
               case 0 % upsampling
                   x_u = upsampling(x,obj); % upsampling operation
                   outp = x_u;
                  
               case 1 % conjugate upsampling
                   x_conj_u = upsampling_conj(x,obj); % conjugate upsampled operation
                   outp = x_conj_u;
                   obj.flag = 0;
                   
               otherwise
                   error('check class upsampOp');
           end   
       end
       
       function obj = ctranspose(obj)
           % conjugate of the upsampling operator
           obj.flag = 1;
       end
       
    end
    
end

