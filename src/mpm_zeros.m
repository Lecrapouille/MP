function [Z] = mpm_zeros(x, y)
   %   (min, +) zeros array
   %
   %   MPM_ZEROS returns (min, +) zero (Inf).
   %   MPM_ZEROS(x) or MPM_ZEROS([x]) is an x-by-x matrix of (min, +) zeros.
   %   MPM_ZEROS(x, y) or MPM_ZEROS([x, y]) is an x-by-y matrix of (min, +) zeros.
   %   MPM_ZEROS(SIZE(A)) is the same size as A and all (min, +) zeros.
   %
   %   See also
   %   MPM_ZERO, MPM_ONE, MPM_ONES, MPM_EYE, MPM_ADD
   %
   %   Introduced in ver.1.02
   %
   %   Max-Plus Algebra Toolbox for Matlab, ver.1.7, 2016-June-14
   %   Copyright (C) 2016 Jaroslaw Stanczyk
   
   narginchk(0, 2);     
   
   switch nargin
      case 0
         Z = inf;
      case 1
         Z = ones(x) * inf;
      case 2
         Z = ones(x, y) * inf;
   end
% end of file