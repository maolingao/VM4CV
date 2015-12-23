classdef averageOp < handle
    % Shift Operator Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        tilesize       % the size of each tile/block to be averaged
        method         % internal method of the function average
        flag           % flag for shift or conjugate shift
    end
    
    methods
        % methods, including the constructor are defined in this block
        
        function obj = averageOp(tilesize,method)
            % class constructor
            if(nargin > 0)     
                obj.tilesize = tilesize;
                obj.method = method;
            end
            obj.flag = 0;
        end
       
       function outp = mtimes(obj,x)
                % x_a         % averaged image
                % x_conj_a    % conjugate averaged image
           switch obj.flag
               case 0 % average
                   x_a = average(x,obj); % average operation
                   outp = x_a;
                  
               case 1 % conjugate average
                   x_conj_a = average(x,obj); % conjugate average operation
                   outp = x_conj_a;
                   obj.flag = 0;
                   
               otherwise
                   error('check class averageOp');
           end   
       end
       
       function obj = ctranspose(obj)
           % conjugate of the shift operator
           obj.flag = 1;
       end
       
    end
    
end

