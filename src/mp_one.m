function [z] = mp_one()
   %   (max, +) unit (0)
   %   (max, +) neutral element for (max, +) multiplication
   %
   %   MP_ONE returns a (max, +) unit - 0
   %
   %   See also
   %   MP_ONES, MP_ZERO, MP_ZEROS, MP_EYE, MP_MULTI
   %
   %   Introduced in ver.1.5
   %
   %   Max-Plus Algebra Toolbox for Matlab, ver.1.7, 2016-June-14
   %   Copyright (C) 2016 Jaroslaw Stanczyk
   
   narginchk(0, 0);
   
   z = 0;
% end of file