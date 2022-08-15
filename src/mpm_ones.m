function [Z] = mpm_ones(x, y)
   %   (min, +) ones array
   %
   %   MPM_ONES returns (min, +) unit (0).
   %   MPM_ONES(x) or MPM_ONES([x]) is an x-by-x matrix of (min, +) ones.
   %   MPM_ONES(x, y) or MPM_ONES([x, y]) is an x-by-y matrix of (min, +) ones.
   %   MPM_ONES(SIZE(A)) is the same size as A and all (min, +) ones.
   %
   %   See also
   %   MPM_ONE, MPM_ZERO, MPM_ZEROS, MPM_EYE, MPM_MULTI
   %
   %   Introduced in ver.1.5
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