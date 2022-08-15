function [check] = mp_is_egv1(A, x, lambda, d)
   %   function chcecks, whether a vector x is an eigenvector of A
   %
   %   MP_IS_EGV1(A, x, lambda, d)
   %
   %   Function returns 1 if x is an eigenvector of A, 0 otherwise,
   %   where:
   %     A is a n-by-n matrix,
   %     x is an n-by-one vector,
   %     lambda (optional) - an eigenvalue of A, default calculated by MP_MCM
   %     d (optional, default = 1) - number of arcs in the maximal cycle mean of A
   %
   %   Function checks:
   %       A \otimes x == lambda \otimes x,
   %   if d > 0 is given then
   %       A^d \otimes x = lambda^d \otimes x
   %
   %   See also
   %   MP_EGV_BO93, MP_EGV_O91, MP_EGV_PQC, MP_EGV_SW001, MP_EGV_SW002,
   %   MP_IS_EGV2, MP_IS_PGA, MP_IS_PGSC1, MP_IS_PGSC2,
   %   MP_MCM, MP_MCM_FW, MP_MCM_KARP
   %
   %   Introduced in ver.1.0
   %
   %   Max-Plus Algebra Toolbox for Matlab, ver.1.7, 2016-June-14
   %   Copyright (C) 2016 Jaroslaw Stanczyk
   
   narginchk(2, 4);
   
   sa = size(A);
   if sa(1, 1) ~= sa(1, 2)
      error('mp_is_egv1: operation is defined for square matrix only!');
   end
   
   sx = size(x);
   if sx(2) ~= 1
      error('mp_is_egv1: wrong vector size!');
   end
   
   if sa(1, 1) ~= sx
      error('mp_is_egv1: inconsistent matrices sizes!');
   end
   
   if x == mp_zeros(sx)
      error('mp_is_egv1: all elements of eigenvector are equal to MP_ZERO!');
   end
   
   switch nargin
   case 2
      l = mp_mcm(A);
      d = 1;
   case 3
      l = lambda; 
      d = 1;
   case 4
      l = lambda; 
   end
   
   if l == mp_zeros
       error('mp_is_egv1: eigenvalue is equal to MP_ZERO!');
   end
   
   % check = isequal(mp_multi(mp_power(A, d), x), mp_multi(mp_power(l, d), x));
   if mp_multi(mp_power(A, d), x) == mp_multi(mp_power(l, d),x)
      check = 1;
   else
      check = 0;
   end
% end of file