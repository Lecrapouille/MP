function [z] = mp_zero()
   %   (max, +) zero (-Inf)
   %   (max, +) neutral element for (max, +) addition
   %
   %   MP_ZERO returns (max, +) zero (-Inf)
   %
   %   See also
   %   MP_ZEROS, MP_ONE, MP_ONES, MP_EYE, MP_ADD
   %
   %   Introduced in ver.1.5
   %
   %   Max-Plus Algebra Toolbox for Matlab, ver.1.7, 2016-June-14
   %   Copyright (C) 2016 Jaroslaw Stanczyk
   
   narginchk(0, 0);
   
   z = -inf;
% end of file