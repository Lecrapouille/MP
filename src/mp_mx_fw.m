function [F] = mp_mx_fw(A, eigenvalue)
   %   (max, +) Floyd-Warshall matrix
   %
   %   [F] = MP_MX_FW(A, eigenvalue)
   %
   %   F - a final Floyd-Warshall matrix, from square matrix A and its eigenvalue
   %       From F can be obtained set of eigenvectors of A by MP_EV_FW
   %
   %   For details see:
   %       G-J.Olsder, K.Roos, and R-J.van Egmond (1999)
   %       "An efficient algorithm for crirical circuits
   %       and finite eigenvectors in the max-plus algebra",
   %       Linear Algebra and its Applications, vol.295, pp.231-240, 1999.
   %
   %   See also
   %   MP_MX_FW, MP_MCM_FW
   %
   %   Introduced in ver.1.02
   %
   %   Max-Plus Algebra Toolbox for Matlab, ver.1.7, 2016-June-14
   %   Copyright (C) 2016 Jaroslaw Stanczyk
   
   narginchk(2, 2);
   
   Wymiar = size(A);
   if Wymiar(1, 1) ~= Wymiar(1, 2)
      error('mp_mx_fw: inconsistent matrix size');
   end
   n = Wymiar(1, 1);
   F = A - eigenvalue;
   for i = 1:n
       F = mp_one_fw(F, i, n);
   end

function [Ak] = mp_one_fw(Ak_1, k, size)
   %MP_ONE_FW
   %   one iteration of the (adopted) Floyd-Warshall procedure
   %
   %   [Ak] = MP_ONE_FW(Ak_1, k)
   %   Ak_1 - n-by-n matrix, in oryginal text it is A_{k-1}
   %   Ak   - n-by-n matrix, in oryginal text it is A_{k}
   %   A_{k}(i, j) = max( A_{k-1}(i, j), A_{k-1}(i, k) + A_{k-1}(k, j) )
   
   for i = 1:size
       for j = 1:size
           Ak(i, j) = max(Ak_1(i, j), Ak_1(i, k) + Ak_1(k, j));
       end
   end
% end of file