function [Z, err] = mpm_div(X, Y)
   %   (min, +) division
   %
   %   [Z] = MPM_DIV(X, Y)
   %   [Z, err] = MPM_DIV(X, Y)
   %
   %   If X is a scalar, and
   %      Y is a scalar, result is a scalar: (min, +) division of X by Y.
   %      Y is a vector (or matrix), result is a vector (or a matrix)
   %          where every entries are: X divided by apropriate entry of Y.
   %
   %   If X is a vector (or matrix), and
   %      Y is a scalar, result is a vector (or a matrix) the same size as X
   %          where every entries of X are (min, +) divided by Y.
   %      Y is a vector (or matrix)
   %          the same size as X: the result is (min, +) division X by Y,
   %              i.e. MPM_MULTI(MPM_INV(X), Y),
   %              If Y is (min, +)-invertable err = 0, otherwise err = 1.
   %          different size - the operation is not defined.
   %
   %   Division by (min, +) zero (Inf) is not defined.
   %
   %   See also
   %   MPM_MULTI, MPM_INV, MPM_ZERO, MPM_ONE
   %
   %   Introduced in ver.1.5
   %
   %   Max-Plus Algebra Toolbox for Matlab, ver.1.7, 2016-June-14
   %   Copyright (C) 2016 Jaroslaw Stanczyk
   narginchk(2, 2);
   
   SizeX = size(X);
   SizeY = size(Y);
   err = 0;
   if (SizeY(1) == SizeY(2)) && SizeY(1) == 1
      Z = mpm_divs(X, Y);
      return;
   end
   
   if (SizeX(1) == SizeX(2)) && SizeX(1) == 1
      for i = 1:SizeY(1)
         for j = 1:SizeY(2)
            Z(i, j) = mpm_divs(X, Y(i, j));
         end
      end
      return;
   end
   
   if (SizeX(1) ~= SizeY(1)) || (SizeX(2) ~= SizeY(2))
      error('mpm_div: inconsistent matrices sizes');
   end
   
   [Yi, err] = mpm_inv(Y);
   Z = mpm_multi(Yi, X);

function [z] = mpm_divs(x, y)
   % x divided by a scalar y
   z = x - y;
   if y == Inf
      % warning('MP_DIVS: operation x / y, where y is mp_zero (-Inf), is not defined!');
      z = mpm_ones(size(x)) * NaN;
   end
   
   if y == -Inf
      [i, j] = find(X == -Inf);
      if isempty(i) == 0
         for k = 1:size(i)
            z(i(k), j(k)) = Inf;
         end
      end
   end
% end of file