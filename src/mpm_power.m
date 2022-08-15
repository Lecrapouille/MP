function [y] = mpm_power(X, n)
   %   (min, +) power of X (scalar or square matrix) to n
   %
   %   MPM_POWER(X, n) = X^n
   %
   %   if X is a scalar function retuens X^n (nX in conventional algebra)
   %                    but if X = mpm_zero then for r > 0  X^n = mpm_zero,
   %                                             for r = 0  X^n = mpm_one,
   %                                             for r < 0  X^n is not defined
   %   if X is a scalar and n is a vector (or matrix)
   %        then a result is a~vector (or a~matrix) this same size,
   %        where every entries is (min, +) power of X to the proper element on n.
   %
   %   If X is a square matrix, n must be non-negative integers or (-1).
   %   If X is a square matrix, and
   %        if n is 0 then result is an identity matrix this same size as X,
   %                  i.e. function calls MPM_EYE(size(X)).
   %        if n is equal to (-1) then the function calls MPM_INV(X).
   %   If X is not a square matrix operation is not defined.
   %
   %   See also
   %   MPM_MULTI, MPM_INV, MPM_DIV, MPM_EYE, MPM_ONE, MPM_ZERO
   %
   %   Introduced in ver.1.5
   %
   %   Max-Plus Algebra Toolbox for Matlab, ver.1.7, 2016-June-14
   %   Copyright (C) 2016 Jaroslaw Stanczyk
   
   narginchk(2, 2);
   
   sizex = size(X);
   if (sizex(1) == 1) && (sizex(2) == 1)
      % X is a scalar
      if  X == mpm_zero
         if n > 0
            y = mpm_zero;
            return
         end
         
         if n == 0
            y = mpm_one;
            return
         end
         
         strerr = sprintf('mpm_power: operation %d^%d is not defined', X, n);
         error(stderr);
      end
      y = n*X;
      
   else
      % X is a matrix
      sizen = size(n);
      if (sizen(1) ~= 1) || (sizen(2) ~= 1)
         error('mpm_power: X^n - n must be a scalar (non-negative integer or -1)');
      end
      
      if isempty(X)
         error('mpm_power: X^n - empty matrix X');
      end
      
      if sizex(1) ~= sizex(2)
         error('mpm_power: X^n is defined for square matrix X only');    
      end
      
      if (n < 0 && n ~= -1) || (n ~= fix(n))
         error('mpm_power: X^n if X is a matrix, operation is defined for n belong to non-negative integers and (-1) only');
      end
      
      if (n == -1)
         [~, err] = mpm_inv(X);
         if err ~= 0
            warning('mpm_power: X^(-1) - X is not (min, +) invertible');
         end
      end
      
      if(n == 0)
         y = mpm_eye(sizex);
         return
      end
      
      y = X;
      if (n > 1)
         for i = 2:n
             y = mpm_multi(y, X);
         end
      end
   end
% end of file