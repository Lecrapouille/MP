function [z] = mpm_zero()
   %   (min, +) zero (Inf)
   %   (min, +) neutral element for (min, +) addition
   %
   %   MPM_ZERO returns (min, +) zero (Inf)
   %
   %   See also
   %   MPM_ZEROS, MPM_ONE, MPM_ONES, MPM_EYE, MP_ADD
   %
   %   Introduced in ver.1.5
   %
   %   Max-Plus Algebra Toolbox for Matlab, ver.1.7, 2016-June-14
   %   Copyright (C) 2016 Jaroslaw Stanczyk
   
   narginchk(0, 0);
   
   z = inf;
end
% end of file