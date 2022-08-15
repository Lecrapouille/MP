function [mcm] = mp_mcm_karp(A)
   %   (max, +) eigenvalue of A
   %   maximum cycle mean of precedence graph 
   %   Karp's algorithm
   %
   %   [mcm] = MP_MCM_KARP(A)
   %
   %   max-plus eigenvalue of an irreducible matrix A,
   %       if A is not irreducible, it gives only one eigenvalue. 
   %   maximum cycle mean of precedence graph G(A)
   %       If G(A) is not strongly connected, it gives only one value.
   %
   %   Function returns:
   %       the eigenvalue of A, or equivalently
   %       the value of maximum cycle mean of precedence graph G(A)
   %   A must be a square matrix
   %
   %   See also
   %   MP_IS_PGA, MP_IS_PGSC1, MP_IS_PGSC2, MP_MCM, MP_MCM_FW
   %
   %   MP_COMPUTE_PQC, MP_EGV1, MP_EGV2, MP_EGV3,  MP_EGV4, 
   %   MP_EGVFLOYDWARSHALL, MP_FLOYDWARSHALLMX, 
   %   MP_ISEGV, MP_ISEGVV, MP_LPQC
   %
   %   Introduced in ver.1.02
   %
   %   Max-Plus Algebra Toolbox for Matlab, ver.1.7, 2016-June-14
   %   Copyright (C) 2016 Jaroslaw Stanczyk
   
   narginchk(1, 1);
   sizeA = size(A);
   if sizeA(1) ~= sizeA(2)
      error('mp_mcm_karp: inconsistent matrix size');
   end
   
   n = sizeA(1, 1);
   An = mp_power(A, n);
   mcm = mp_zero();
   for i = 1:n
       for j = 1:n
          if (An(i, j) ~= mp_zero())
             pom = Inf;
             for k = 1:n
                Ak = mp_power(A, n-k);
                pom = min(mp_power(mp_div(An(i, j), Ak(i, j)), 1/k), pom);
             end
             mcm = mp_add(mcm, pom);
          end
       end
   end
% end of file