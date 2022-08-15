function [check] = mp_is_egv2(x2, x1, lambda, d)
   %   chcecks: lambda^d \otimes x1 == x2
   %
   %   MP_IS_EGV2(x2, x1, lambda, d)
   %
   %   Function returns 1 if lambda \otimes x1 == x2, 0 otherwise.
   %   where:
   %     x2 is a n-by-one vector (= A \otimes x1),
   %     x1 is a n-by-one vector,
   %     lambda is an eigenvalue of A,
   %     d (optional) - number of arcs in maximal cycle mean of A, default = 1.
   %
   %   if d > 0 is given then function checks
   %       lambda^d \otimes x1 == x2
   %
   %   See also
   %   MP_EGV_BO93, MP_EGV_O91, MP_EGV_PQC, MP_EGV_SW001, MP_EGV_SW002,
   %   MP_IS_EGV1, MP_IS_PGA, MP_IS_PGSC1, MP_IS_PGSC2,
   %   MP_MCM, MP_MCM_FW, MP_MCM_KARP
   %
   %   Introduced in ver.1.0
   %
   %   Max-Plus Algebra Toolbox for Matlab, ver.1.7, 2016-June-14
   %   Copyright (C) 2016 Jaroslaw Stanczyk
   
   narginchk(3, 4);
   switch nargin
   case 3
      d = 1;
      l = lambda;
   case 4
      l = lambda;
   end
   
   s1 = size(x1);
   s2 = size(x2);
   if s1(1) ~= s2(1)
      error('mp_is_egv2: inconsistent vectors sizes');
   end
   
   if s1(2) ~= 1
      error('mp_is_egv2: wrong size of vector X1');
   end
   
   if s2(2) ~= 1
      error('mp_is_egv2: wrong size of vector X2');
   end
   
   if x1 == mp_zeros(s1)
      error('mp_is_egv2: all elements of vector X1 are equal to MP_ZERO!');
   end
   
   if x2 == mp_zeros(s1)
      error('mp_is_egv2: all elements of vector X2 are equal to MP_ZERO!');
   end
   
   if l == mp_zeros
       error('mp_is_egv2: lambda is equal to MP_ZERO!');
   end
   
   % check = isequal(x2, mp_multi(x1, mp_power(l, d)));
   if x2 == mp_multi(x1, mp_power(l, d))
      check = 1;
   else
      check = 0;
   end
% end of file