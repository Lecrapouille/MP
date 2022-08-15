function [Z] = mp_add(X, Y)
   %   (max, +) addition
   %
   %   MP_ADD(X, Y)
   %   If X and Y are scalars, result is a (max, +) sum of X and Y.
   %   If X (or Y) is scalar and Y (or X) is vector,
   %       result is a vector the same size as Y (or X)
   %       where for every entries is (max, +) added X (or Y).
   %   If X (or Y) is scalar and Y (or X) is matrix,
   %       result is a matrix the same size as Y (or X)
   %       where for every entries is (max, +) added X (or Y).
   %   If X and Y are this same size matrices,
   %       result is an array the same size as X and Y
   %       with the entries equal to (max, +) addition elements from X and Y.
   %
   %   See also
   %   MP_MULTI, MP_ONE, MP_ONES, MP_ZERO, MP_ZEROS
   %
   %   Introduced in ver.1.0
   %
   %   Max-Plus Algebra Toolbox for Matlab, ver.1.7, 2016-June-14
   %   Copyright (C) 2016 Jaroslaw Stanczyk
   
   narginchk(2, 2);
   
   sizeX = size(X);
   sizeY = size(Y);
   if ((sizeX(1, 1) == sizeX(1, 2)) && (sizeX(1, 1) == 1)) || ((sizeY(1, 1) == sizeY(1, 2)) && (sizeY(1, 1) == 1))
      Z = max(X, Y);
      return
   end
   
   if (sizeX ~= sizeY)
      error('mp_add: nonconformant arguments (op1 is %dx%d, op2 is %dx%d)', sizeX(1, 1), sizeX(1, 2), sizeY(1, 1), sizeY(1, 2));
   end
   Z = max(X, Y);
% end of file