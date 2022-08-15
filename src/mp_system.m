function [X] = mp_system(A, x0, k, one_only)
   %   state of an autonomous linear max-plus system (state-space model)
   %
   %   MP_SYSTEM(A, x0, k, one_only)
   %
   %   States of an autonomous linear max-plus system
   %       x(k) = Ax(k-1)
   %   where
   %       A is a system matrix
   %       x0 is a initial state vector, x0= x(0)
   %       k is a cycle index (iteration number)
   %       one_only (optional, default one_only = 1)
   %           if is set to 1, the result is a state vector x(k)
   %           if one_only = 0, the result is a matrix of a collection of
   %           state vectors from x(0) to x(k)
   %
   %   See also
   %   MP_MULTI
   %
   %   Introduced in ver.1.0
   %
   %   Max-Plus Algebra Toolbox for Matlab, ver.1.7, 2016-June-14
   %   Copyright (C) 2016 Jaroslaw Stanczyk
   
   narginchk(3, 4);
   
   switch nargin
   case 3
      one_only = 1;
   end
   
   if isempty(A)
      error('mp_system: empty input value');
   end
   sizeA = size(A);
   if sizeA(1) ~= sizeA(2)
      error('mp_system: inconsistent matrix size!');
   end
   
   sizeX = size(x0);
   if sizeA(1) ~= sizeX(1)
       error('mp_system: inconsistent matrix and initial vector sizes!');
   end
   if sizeX(2) ~= 1
       error('mp_system: initial vector must be a column vector!');
   end
   
   z(:, 1) = x0;
   for i = 1:k
       z(:, i + 1) = mp_multi(A, z(:, i));
   end
   
   if one_only
       X = z(:, k + 1);
   else
       X = z(:, :);
   end
% end of file