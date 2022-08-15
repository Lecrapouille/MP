function [Z] = mpm_multi(X, Y)
   %  (min +) multiplication
   %
   %   MPM_MULTI(X, Y)
   %   If X and Y are scalars, result is a (min, +) multiplication of X and Y.
   %   If X (or Y) is scalar and Y (or X) is vector,
   %       result is a vector the same size as Y (or X)
   %       where every entries of Y (or X) are (min, +) multiplicated by X (or Y).
   %   If X (or Y) is scalar and Y (or X) is matrix,
   %       result is a matrix the same size as Y (or X)
   %       where every matrix entries are (min, +) multiplicated by X (or Y).
   %   if X is an m x p matrix and Y is an p x n matrix
   %       result is a (min, +) product of X and Y returns an m x n array.
   %
   %   See also
   %   MPM_ADD, MPM_DIV, MPM_INV, MPM_POWER, MPM_ONE, MPM_ONES, MPM_ZERO, MPM_ZEROS
   %
   %   Introduced in ver.1.5
   %
   %   Max-Plus Algebra Toolbox for Matlab, ver.1.7, 2016-June-14
   %   Copyright (C) 2016 Jaroslaw Stanczyk
   
   function [C] = mpm_scalar_multi(A, B)
      C = A + B;

      if A == Inf
         [i, j] = find(B == -Inf);
         if isempty(i) == 0
            for k = 1:size(i)
               C(i(k), j(k)) = Inf;
            end
         end
      end

      if A == -Inf
         [i, j] = find(B == Inf);
         if isempty(i) == 0
            for k = 1:size(i)
               C(i(k), j(k)) = Inf;
            end
         end
      end
   end
   
   narginchk(2, 2)
   
   sizeX = size(X);
   sizeY = size(Y);
   
   if ((sizeX(1, 1) == sizeX(1, 2)) && (sizeX(1, 1) == 1))
      % scalar * (matrix or vector or scalar)
      if (isempty(Y))
         Z = Y;
         return
      end
      Z = mpm_scalar_multi(X, Y);
      
   elseif ((sizeY(1, 1) == sizeY(1, 2)) && (sizeY(1, 1) == 1))
      % matrix or vector * scalar
      if (isempty(X))
         Z = X;
         return
      end
      Z = mpm_scalar_multi(Y, X);
      
   elseif (sizeX(1,2) ~= sizeY(1,1))
      error('mpm_multi: nonconformant arguments (op1 is %dx%d, op2 is %dx%d)', sizeX(1, 1), sizeX(1, 2), sizeY(1, 1), sizeY(1, 2));
      
   else
      % calculation for matrices
      for i = 1:sizeX(1, 1)
         for j = 1:sizeY(1, 2)
            pom = X(i, :)' + Y(:, j);
            [m] = find(X(i, :) == -Inf);
            [n] = find(Y(:, j) == Inf);
            if (isempty(m) == 0 && isempty(n) == 0)
               for k = 1:size(m)
                  if m(k) == n(k)
                     pom(m) = Inf;
                  end
               end
            end
            [m] = find(X(i, :) == Inf);
            [n] = find(Y(:, j) == -Inf);
            if (isempty(m) == 0 && isempty(n) == 0)
                for k = 1:size(m)
                    if m(k) == n(k)
                        pom(m) = Inf;
                    end
                end
            end
            Z(i, j) = min(pom);
         end
      end
   end
end
% end of file