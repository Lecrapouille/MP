function [z] = mpm_one()
   %   (min, +) algebraic unit (0)
   %   (min, +) neutral element for (min, +) multiplication
   %
   %   MP_ONE returns a (min, +) unit - 0
   %
   %   See also
   %   MPM_ONES, MPM_ZERO, MPM_ZEROS, MPM_EYE, MPM_MULTI
   %
   %   Introduced in ver.1.5
   %
   %   Max-Plus Algebra Toolbox for Matlab, ver.1.7, 2016-June-14
   %   Copyright (C) 2016 Jaroslaw Stanczyk
   
   narginchk(0, 0);
   
   z = 0;
end
% end of file