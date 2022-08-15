function [Z] = mp_conv(X)
   %   conversion scalar, vector or matrix from (max,+) to (min,+) and vice versa
   %
   %   Z = MP_CONV(X)
   %
   %   Function exchanges all 'Inf' and '-Inf' for '-Inf' and 'Inf' respectively.
   %   Entries with other values are not changing.
   %
   %   See also
   %   MP_MX2LATEX, MPM_MX2LATEX
   %
   %   Introduced in ver.1.5
   %
   %   Max-Plus Algebra Toolbox for Matlab, ver.1.7, 2016-June-14
   %   Copyright (C) 2016 Jaroslaw Stanczyk
   
   narginchk(1, 1);
   
   % -Inf -> Inf
   B = X == (-Inf);
   B *= Inf;
   Z = max(X, B);
   
   % Inf -> -Inf
   B = X == Inf;
   B *= (-Inf);
   Z = min(Z, B);
% end of file