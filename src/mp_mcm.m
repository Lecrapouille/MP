function [l, d] = mp_mcm(A)
   %   maximum cycle mean of precedence graph G(A)
   %   (max-plus eigenvalue
   %
   %   [eigenvalue, d] = MP_MCM(A)
   %
   %   max-plus eigenvalue of an irreducible matrix A
   %       if A is not irreducible, it gives only one eigenvalue
   %   maximum cycle mean of precedence graph G(A)
   %       if G(A) is not strongly connected, it gives only one value
   %
   %   Function returns:
   %       eigenvalue of A or equivalently,
   %       value of maximum cycle mean of precedence graph G(A)
   % 
   %       d - a number of arcs in critical circuit
   %   A must be a square matrix.
   %
   %   See also 
   %   MP_IS_PGA, MP_IS_PGSC1, MP_IS_PGSC2, MP_MCM_FW, MP_MCM_KARP
   %
   %   MP_COMPUTE_PQC, MP_EGV1, MP_EGV2, MP_EGV3,  MP_EGV4, 
   %   MP_EGVFLOYDWARSHALL, MP_FLOYDWARSHALLMX, 
   %   MP_ISEGV, MP_ISEGVV, MP_LPQC
   %
   %   Introduced in ver.1.0
   %
   %   Max-Plus Algebra Toolbox for Matlab, ver.1.7, 2016-June-14
   %   Copyright (C) 2016 Jaroslaw Stanczyk
   
   narginchk(1, 1);
   if isempty(A)
      error('mp_mcm: empty input value');
   end
   sizeA=size(A);
   if sizeA(1, 1) ~= sizeA(1, 2)
      error('mp_mcm: inconsistent matrix size');
   end
   
   n = sizeA(1, 1);  
   for i = 1:n
      C1(i) = mp_power(mp_trace(mp_power(A, i)), 1/i);
   end
   [l, d] = max(C1);
% end of file