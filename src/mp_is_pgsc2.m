function [c] = mp_is_pgsc2(A)
   %   is precedence graph strongly connected?
   %   is matrix irreducible?
   %   has matrix got exactly one eigenvalue?
   %
   %   MP_IS_PGSC2(A)
   %
   %   Function returns 1:
   %       if precedence graph G(A) is strongly connected, or equivalently
   %       if matrix A is irreducible, or
   %       if matrix A has got exactly one eigenvalue,
   %   0 otherwise.
   %   A must be a square matrix.
   %
   %   Here is used a classical (and simple) algorithm, i.e.
   %       B = A \oplus A^2 \oplus ... \oplus A^n
   %   G(A) is strongly connected iff each entry in B is greater than mp_zero().
   %
   %   See also 
   %   MP_IS_PGA, MP_IS_PGC, MP_IS_PGSC1,
   %   MP_MCM, MP_MCM_FW, MP_MCM_KARP
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
      error('MP_IS_PGSC2: empty input value');
   end
   sizeA = size(A);
   if sizeA(1,1) ~= sizeA(1, 2)
      error('MP_IS_PGSC2: inconsistent matrix size');
   end
   
   n = sizeA(1,1);
   B = A;
   for i = 2:n
      B = mp_add(B, mp_power(A, i));
   end
   
   if sum(sum(B)) == mp_zero()
       c = 0;
       return
   end
   c = 1;
% end of file