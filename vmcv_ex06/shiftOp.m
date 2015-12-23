classdef shiftOp < handle
    % Shift Operator Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        shift       % the amount of shift
        bbox        % the internal method for the function imshift
        flag        % flag for shift or conjugate shift
    end
    
    methods
        % methods, including the constructor are defined in this block
        
        function obj = shiftOp(shift,bbox)
            % class constructor
            if(nargin > 0)     
                obj.shift = shift;
                if (nargin < 3)
                    obj.bbox = 'same';
                else
                    obj.bbox = bbox;
                end
            end
            obj.flag = 0;
        end
       
       function outp = mtimes(obj,x)
                % x_s         % shifted image
                % x_conj_s    % conjugate shifted image
           switch obj.flag
               case 0 % shift
                   x_s = imshift(x, obj.shift, obj.bbox); % shift operation
                   outp = x_s;
                  
               case 1 % conjugate shift
                   shift_conj = -obj.shift;
                   x_conj_s = imshift(x, shift_conj, obj.bbox); % conjugate shift operation
                   outp = x_conj_s;
                   obj.flag = 0;
                   
               otherwise
                   error('check class shiftOp');
           end   
       end
       
       function obj = ctranspose(obj)
           % conjugate of the shift operator
           obj.flag = 1;
       end
       
    end
    
end

