function [c] = mp_is_pgsc1(A)
   %   is precedence graph strongly connected?
   %   is matrix irreducible?
   %   has matrix got exactly one eigenvalue?
   %
   %   MP_IS_PGSC1(A)
   %
   %   Function returns 1:
   %       if precedence graph G(A) is strongly connected, or equivalently
   %       if matrix A is irreducible, or
   %       if matrix A has got exactly one eigenvalue,
   %   0 otherwise.
   %   A must be a square matrix.
   %
   %   See also
   %   MP_IS_PGA, MP_IS_PGC, MP_IS_PGSC2,
   %   MP_MCM, MP_MCM_FW, MP_MCM_KARP
   %
   %   MP_COMPUTE_PQC, MP_EGV1, MP_EGV2, MP_EGV3,  MP_EGV4
   %   MP_EGVFLOYDWARSHALL, MP_FLOYDWARSHALLMX,
   %   MP_ISEGV, MP_ISEGVV, MP_LPQC
   %
   %   Introduced in ver.1.01
   %
   %   Max-Plus Algebra Toolbox for Matlab, ver.1.7, 2016-June-14
   %   Copyright (C) 2016 Jaroslaw Stanczyk
   
   narginchk(1, 1);
   if isempty(A)
      error('mp_is_pgsc1: empty input value');
   end
   
   sizeA = size(A);
   if sizeA(1, 1) ~= sizeA(1, 2)
      error('mp_is_pgsc1: inconsistent matrix size');
   end
   
   n = sizeA(1, 1);  
   for l = 1:n
       for i = 1:n
           A(i, i) = 0;
           for j = 1:n
               if A(j, i) > mp_zero()
                   A(j, i) = 0;
                   for k = 1:n
                       if A(k, j) > mp_zero()
                           A(k, i) = 0;
                       end
                   end
               end
           end
       end
   end
   
   if sum(sum(A)) == mp_zero()
      c = 0;
      return
   end
   c = 1;
% end of file