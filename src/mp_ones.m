function [Z] = mp_ones(x, y)
   %   (max, +) ones array
   %
   %   MP_ONES returns (max, +) unit (0).
   %   MP_ONES(x) or MP_ONES([x]) is an x-by-x matrix of (max, +) ones.
   %   MP_ONES(x, y) or MP_ONES([x, y]) is an x-by-y matrix of (max, +) ones.
   %   MP_ONES(SIZE(A)) is the same size as A and all (max, +) ones.
   %
   %   See also
   %   MP_ONE, MP_ZERO, MP_ZEROS, MP_EYE, MP_MULTI
   %
   %   Introduced in ver.0.1
   %
   %   Max-Plus Algebra Toolbox for Matlab, ver.1.7, 2016-June-14
   %   Copyright (C) 2016 Jaroslaw Stanczyk
   
   narginchk(0, 2);
   
   switch nargin
      case 0
         Z = 0;
      case 1
         Z = zeros(x);
      case 2
         Z = zeros(x, y);
   end
% end of file