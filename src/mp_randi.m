function [Z] = mp_randi(imax, varargin)
   %   (max, +) random integer + mp_zero (-Inf)
   %
   %   mp_randi (IMAX)
   %   mp_randi (IMAX, N)
   %   mp_randi (IMAX, M, N)
   %   mp_randi ([IMIN IMAX], ...)
   %
   %   Return random integers in the range 1:IMAX (or IMIN:IMAX) + mp_zero.
   %   Additional arguments determine the shape of the return matrix.
   %   For more info look at randi()
   %
   %   See also
   %
   %   Introduced in ver.1.7
   %
   %   Max-Plus Algebra Toolbox for Matlab, ver.1.7, 2016-June-14
   %   Copyright (C) 2016 Jaroslaw Stanczyk
   
   narginchk(1, 3);
   
   switch nargin
      case 1
         A = randi(imax);
      case 2
         A = randi(imax, varargin{1});
      case 3
         A = randi(imax, varargin{1}, varargin{2});
      otherwise
         error('mp_randi: nonsupportet amount of arguments');
   end
   [m, n] = size(imax);
   B = (randi(imax, size(A)) == imax(m, n)) * mp_zero;
   Z = min(A, B);
% end of file