function [e] = mp_ev_fw(A)
   %   matrix of eigenvectors from A matrix
   %
   %   [e] = MP_EV_FW(A)
   %
   %   Function returns a set of eigenvectors of A from final Floyd--Warshall
   %      matrix A genenerated by MP_MCM_FW or MP_MX_FW 
   %      without recurrent eigenvectors
   %
   %   For details see:
   %       G-J.Olsder, K.Roos, and R-J.van Egmond (1999)
   %       "An efficient algorithm for crirical circuits
   %       and finite eigenvectors in the max-plus algebra"
   %       Linear Algebra and its Applications, vol.295, pp.231-240, 1999.
   %
   %   See also
   %   MP_MX_FW, MP_MCM_FW
   %
   %   Introduced in ver.1.02
   %
   %   Max-Plus Algebra Toolbox for Matlab, ver.1.7, 2016-June-14
   %   Copyright (C) 2016 Jaroslaw Stanczyk
   
   narginchk(1, 1);
   
   Wymiar = size(A);
   if Wymiar(1, 1) ~= Wymiar(1, 2)
       error('mp_ev_fw: inconsistent matrix size');
   end
   
   zerosCounter = 0;
   for i = 1:Wymiar(1, 1)
      if A(i, i) == 0
          zerosCounter = zerosCounter + 1;
          AfwMod(:, zerosCounter) = A(:, i);
      end
   end
   
   egvCounter = 0;
   for i = 1:zerosCounter
      for j = i:zerosCounter
         x = max(AfwMod(:, i), AfwMod(:, j));
         if find(x == -inf)
         else
            egvCounter = egvCounter + 1;
            eigen(:, egvCounter) = x;
         end
       end
   end
   
   e = [];
   count = 0;
   for i = 1 : egvCounter
       if existInMat(eigen(:, i), e, count, Wymiar(1, 1)) == 0
           count = count + 1;
           e(:, count) = eigen(:, i);
       end
   end

function result = existInMat(vect, matrix, size, s)
   result = 0;
   if size > 0
      for i = 1:size
         if vect == matrix(:, i)
            result = 1;
            return
         end
         k = vect - matrix(:, i);
         pk = ones(s, 1) * k(1);
         if isequal(pk, k)
            result = 1;
            return
         end
      end
   end
% end of file