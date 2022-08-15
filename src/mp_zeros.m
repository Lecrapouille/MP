function [Z] = mp_zeros(x, y)
   %   (max, +) zeros array
   %
   %   MP_ZEROS returns (max, +) zero (-Inf).
   %   MP_ZEROS(x) or MP_ZEROS([x]) is an x-by-x matrix of (max, +) zeros.
   %   MP_ZEROS(x, y) or MP_ZEROS([x, y]) is an x-by-y matrix of (max, +) zeros.
   %   MP_ZEROS(SIZE(A)) is the same size as A and all (max, +) zeros.
   %
   %   See also 
   %   MP_ZERO, MP_ONE, MP_ONES, MP_EYE, MP_ADD
   %
   %   Introduced in ver.0.1
   %
   %   Max-Plus Algebra Toolbox for Matlab, ver.1.7, 2016-June-14
   %   Copyright (C) 2016 Jaroslaw Stanczyk
   
   narginchk(0, 2);
   
   switch nargin
      case 0
         Z = -inf;
      case 1
         Z = ones(x) * -inf;
      case 2
         Z = ones(x, y) * -inf;
   end
% end of file