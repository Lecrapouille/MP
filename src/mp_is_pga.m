function [c] = mp_is_pga(A)
   %   is precedence graph associated with A acyclic?
   %   has matrix A got any eigenvalue?
   %
   %   MP_ISPGA(A)
   %
   %   Return 1 if precedence graph associated with A is acyclic, 0 otherwise.
   %   Equivalently, if A has NOT got any eigenvalue, function returns 1, 0 otherwise.
   %   Matrix A must be a square matrix.
   %
   %   See also
   %   MP_IS_PGC, MP_IS_PGSC1, MP_IS_PGSC2,
   %   MP_MCM, MP_MCM_KARP, MP_MCM_FW
   %
   %   MP_COMPUTE_PQC, MP_EGV1, MP_EGV2, MP_EGV3,  MP_EGV4
   %   MP_EGVFLOYDWARSHALL, MP_FLOYDWARSHALLMX,
   %   MP_ISEGV, MP_ISEGVV, MP_LPQC
   %
   %   Introduced in ver.1.02
   %
   %   Max-Plus Algebra Toolbox for Matlab, ver.1.7, 2016-June-14
   %   Copyright (C) 2016 Jaroslaw Stanczyk
   
   narginchk(1, 1);
   if isempty(A)
      error('mp_is_pga: empty input value');
   end
   
   sizeA = size(A);
   if sizeA(1, 1) ~= sizeA(1, 2)
      error('mp_is_pga: inconsistent matrix size');
   end
   
   if mp_trace(A) > mp_zero()
      c = 0;
      return
   end
   
   n = sizeA(1, 1);
   for i = 2:n
      if mp_trace(mp_power(A, i)) > mp_zero()
         c = 0;
         return
      end
   end
   c = 1;
% end of file