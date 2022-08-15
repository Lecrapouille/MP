function [eigenvalue, Afw] = mp_mcm_fw(A)
   %   (max, +) eigenvalue
   %
   %   [eigenvalue, Afw] = MP_MCM_FW(A)
   %
   %   (max, +) eigenvalue of an irreducible matrix A
   %      if A is not irreducible, it gives only one eigenvalue.
   %   or
   %   Maximum cycle mean of precedence graph G(A)
   %      if G(A) is not strongly connected, it gives only one value
   %
   %   Function returns:
   %       eigenvalue of A (a maximum cycle mean of G(A))
   %       Afw - a final Floyd--Warshall's matrix, 
   %       from Afw matrix can be obtained a set of eigenvectors by MP_EV_FW,
   %       A must be a square matrix.
   %
   %   For details see:
   %       G-J.Olsder, K.Roos, and R-J.van Egmond (1999)
   %       "An efficient algorithm for crirical circuits
   %       and finite eigenvectors in the max-plus algebra",
   %       Linear Algebra and its Applications, vol.295, pp.231-240, 1999.
   %
   %   See also
   %   MP_EV_FW, MP_MX_FW, MP_EGV_BO93, MP_EGV_O91, MP_EGV_PQC, MP_EGV_SW001, 
   %   MP_EGV_SW002, MP_IS_PGA, MP_IS_PGSC1, MP_IS_PGSC2, MP_IS_EGV1, MP_IS_EGV2, 
   %   MP_MCM, MP_MCM_KARP
   %
   %   Introduced in ver.1.02
   %
   %   Max-Plus Algebra Toolbox for Matlab, ver.1.7, 2016-June-14
   %   Copyright (C) 2016 Jaroslaw Stanczyk
   
   narginchk(1, 1);
   sizeA = size(A);
   if sizeA(1, 1) ~= sizeA(1, 2)
      error('mp_mcm_fw: inconsistent matrix size');
   end
   
   if mp_is_pga(A) == 1
      eigenvalue = -inf;
      Afw = [ ];
      return;
   end
   
   % start a procedure
   % we start by choosing a lower bound for lambda_star
   % if the diagonal of A is not void
   mu = mp_traceMod(A, sizeA(1, 1));
   % if it is void
   if mu == -inf
      % mu := min_{i,j}(A), but not -inf
      % because the average weight of circuit can not be smaller
      for i = 1:sizeA(1, 1)
         for j = 1:sizeA(1, 1)
            if A(i, j) ~= -inf
               if mu == -inf
                  mu = A(i, j);
               elseif A(i, j) < mu
                  mu = A(i, j);
               end
            end
         end
      end
   end
   
   J = ones(sizeA(1, 1));
   C_exists = 1;
   P = makePredArray(A, sizeA(1,1));
   while C_exists > 0
      C_exists = 0;
      % we check, whether there exists a circuit C with positive weight with respect to (A - mu J)
      Afw = A - mu*J;
      for i = 1:sizeA(1, 1)
         [Afw, P] = mp_prFloydWarshall(Afw, P, i, sizeA(1, 1));
         [pm, node] = mp_traceMod(Afw, sizeA(1, 1));
         if pm > 0
            mu = mp_backFloydWarshall(A, P, node);
            C_exists = 1;
            break;
         end
      end
      % if there exists a circuit C with positive weight,
      % we increase mu to the average weight of C (with respect to A)
      % and restart the procedure.
      % This is repeated til there are no circuits having positive weight
      % with respect to A' := A - mu J
   end
   eigenvalue = mu;

function [Ak, PredArray] = mp_prFloydWarshall(Ak_1, PredArray, k, size)
   %mp_prfloydWarshall
   %   one iteration of the (adopted) Floyd-Warshall procedure
   %
   %   [Ak] = mp_floydWarshall(Ak_1, k)
   %   Ak_1 --- n-by-n matrix, in oryginal text it is A_{k-1}
   %   Ak   --- n-by-n matrix, in oryginal text it is A_{k}
   %       A_{k}(i,j) = max( A_{k-1}(i,j), A_{k-1}(i,k) + A_{k-1}(k,j) )
   for i = 1:size
      for j = 1:size
         Ak(i, j) = max(Ak_1(i, j), Ak_1(i, k) + Ak_1(k, j));
         if Ak_1(i, j) < Ak(i, j)
            PredArray(i, j) = k;
         end
      end
   end

function [v, node] = mp_traceMod(A, size)
   v = A(1, 1);
   node = 1;
   for i = 1:size
      if A(i, i) > v
         v = A(i, i);
         node = i;
      end
   end

function PredArray = makePredArray(matrix, size)
   PredArray = zeros(size);
   for i = 1:size
      for j = 1:size
         if matrix(i, j) ~= -Inf
            PredArray(i, j) = j;
         end
      end
   end

function cm = mp_backFloydWarshall(matrix, PredArray, node)
   next = PredArray(node, node);
   prev = node;
   count = 0;
   cm = 0;
   while next ~= node
      count = count + 1;
      cm = cm + matrix(prev, next);
      prev = next;
      next = PredArray(prev, node);
   end
   cm = cm + matrix(prev, next);
   count = count + 1;
   cm = cm / count;
% end of file