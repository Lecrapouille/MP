function [Z] = mpm_eye(x, y)
   %   (min, +) identity matrix
   %
   %   MPM_EYE returns (min, +) unit (0).
   %   MPM_EYE(x) or MPM_EYE([x]) is an x-by-x (min, +) identity matrix
   %       with mpm_one (0) on the main diagonal
   %       and mpm_zero (Inf) elsewhere,
   %   MPM_EYE(x, y) or MPM_EYE([x, y]) is an x-by-y matrix
   %       of mpm_one on the main diagonal
   %   MPM_EYE(SIZE(A)) returns MPM_EYE matrix, the same size as A.
   %
   %   See also
   %   MPM_ONE, MPM_ONES, MPM_ZERO, MPM_ZEROS
   %
   %   Introduced in ver.1.5
   %
   %   Max-Plus Algebra Toolbox for Matlab, ver.1.7, 2016-June-14
   %   Copyright (C) 2016 Jaroslaw Stanczyk
   
   narginchk(0, 2);
   
   switch nargin
      case 0
         Z = mpm_one;
      case 1
         Z = mpm_zeros(x);
         for i = 1:x
            Z(i, i) = mpm_one;
         end
      case 2
         sizeX = size(x);
         if (sizeX(1) ~= 1) || (sizeX(2) ~= 1)
            error('mpm_eye: imput parameter x should be a scalar, not a matrix');
         end
         Z = mpm_zeros(x, y);
         for i = 1:x
            Z(i, i) = mpm_one;
         end
   end
% end of file