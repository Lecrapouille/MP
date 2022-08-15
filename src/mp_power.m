function [y] = mp_power(X, n)
   %   (max, +) power of X (scalar or square matrix) to n
   %
   %   MP_POWER(X, n) = X^n
   %
   %   if X is a scalar function retuens X^n (nX in conventional algebra)
   %                    but if X = mp_zero then for r > 0  X^n = mp_zero,
   %                                            for r = 0  X^n = mp_one,
   %                                            for r < 0  X^n is not defined
   %   if X is a scalar and n is a vector (or matrix) 
   %        then a result is a~vector (or a~matrix) this same size, 
   %        where every entries is (max, +) power of X to the proper element on n.
   %
   %   If X is a square matrix, n must be non-negative integers or (-1).
   %   If X is a square matrix, and
   %        if n is 0 then result is an identity matrix this same size as X,
   %                  i.e. function calls MP_EYE(size(X)).
   %        if n is equal to (-1) then the function calls MP_INV(X).
   %   If X is not a square matrix operation is not defined.
   %
   %   See also
   %   MP_MULTI, MP_INV, MP_DIV, MP_EYE, MP_ONE, MP_ZERO
   %
   %   Introduced in ver.1.0
   %
   %   Max-Plus Algebra Toolbox for Matlab, ver.1.7, 2016-June-14
   %   Copyright (C) 2016 Jaroslaw Stanczyk
   
   narginchk(2, 2);
   
   sizex = size(X);
   if (sizex(1) == 1) && (sizex(2) == 1)
      % X is a scalar
      if  X == mp_zero
         if n > 0
            y = mp_zero;
            return
         end
         
         if n == 0
            y = mp_one;
            return
         end
         
         error('mp_power: operation %d^%d is not defined', X, n);
      end
      y = n * X;
      
   else
      % X is a matrix
      sizen = size(n);
      if (sizen(1) ~= 1) || (sizen(2) ~= 1)
         error('mp_power: X^n - n must be a scalar (non-negative integer or -1)');
      end
      
      if isempty(X)
         error('mp_power: X^n - empty matrix X');
      end
      
      if sizex(1) ~= sizex(2)
         error('mp_power: X^n is defined for square matrix X only');    
      end
      
      if (n < 0 && n ~= -1) || (n ~= fix(n))
         error('mp_power: X^n if X is a matrix, operation is defined for n belong to non-negative integers and (-1) only');
      end
      
      if (n == -1)
         [y, err] = mp_inv(X);
         if err ~= 0
            warning('mp_power: X^(-1) - X is not (max, +) invertible');
         end
      end
      
      if(n == 0)
         y = mp_eye(sizex);
         return
      end
      
      y = X;
      if (n > 1)
         for i = 2:n
             y = mp_multi(y, X);
         end
      end
   end
% end of file