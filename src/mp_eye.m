function [Z] = mp_eye(x, y)
   %   (max, +) identity matrix
   %
   %   MP_EYE returns (max, +) unit (0).
   %   MP_EYE(x) or MP_EYE([x]) returns an x-by-x (max, +) identity matrix
   %       with mp_one (0) on the main diagonal
   %       and mp_zero (-inf) elsewhere.
   %   MP_EYE(x, y) or MP_EYE([x, y]) returns an x-by-y matrix
   %       with mp_one on the main diagonal and mp_zero-s elsewhere.
   %   MP_EYE(SIZE(A)) returns MP_EYE matrix the same size as A.
   %
   %   See also
   %   MP_ONE, MP_ONES, MP_ZERO, MP_ZEROS, MP_RANDI
   %
   %   Introduced in ver.1.5
   %
   %   Max-Plus Algebra Toolbox for Matlab, ver.1.7, 2016-June-14
   %   Copyright (C) 2016 Jaroslaw Stanczyk
   
   narginchk(0, 2);
   
   switch nargin 
      case 0
         Z = mp_one;
      case 1
         Z = mp_zeros(x);
         for i = 1:x
            Z(i, i) = mp_one;
         end
      case 2
         sizeX = size(x);
         if (sizeX(1) ~= 1) || (sizeX(2) ~= 1)
            error('mp_eye: imput parameter x should be a scalar, not a matrix');
         end
         Z = mp_zeros(x, y);
         for i = 1:x
           Z(i, i) = mp_one;
         end
   end
% end of file