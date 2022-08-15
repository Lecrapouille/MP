function [Z, n] = mp_star(A)
   %  (max, +) star operator
   %
   %  [Z, n] = MP_STAR(A)
   %  - Z = A* = A^0 + A^1 + A^2 + ...
   %  - n - minimal value for what all entries in A^n are equal to -Inf's
   %
   %  It solves x = Ax + b
   %       i.e. x = A*b
   %  when there is no circuits with positive weight in graph G(A)
   %    Z = A* = A^0 + A^1 + A^2 + ... + A^(m-1)
   %    where m denotes the order of the square matrix A
   %  A must be a square matrix.
   %
   %  See also
   %  MP_SOLVE_AXB, MP_SOLVE_XAXB,
   %  MP_IS_PGA, MP_IS_PGC, MP_IS_PSC1, MP_IS_PSC2,
   %  MP_MCM, MP_MCM_FW, MP_MCM_KARP
   %
   %  Introduced in ver.1.0
   %
   %  Max-Plus Algebra Toolbox for Matlab, ver.1.7, 2016-June-14
   %  Copyright (C) 2016 Jaroslaw Stanczyk
   
   narginchk(1, 1);
   
   if isempty(A)
      error('mp_star: empty input matrix')
   end
   
   % calculate
   [m, n]=size(A);
   if m ~= n
      error('mp_star: star operator is defined for square matrix only!')
   end
   E = mp_eye(m);
   
   n = 0;
   j = m * m;
   odp = 1;
   
   Z = E;
   while odp
      n = n + 1;
      if n > m
         n = Inf;
         for i = 1:m
            for j = 1:m
               Ai = mp_power(A, m + 1);
               if Z(i, j) ~= mp_zero && Z(i, j) ~= mp_one
                  if Z(i, j) < Ai(i, j)
                     if Z(i, j) < mp_one
                        Z(i, j) = mp_zero;
                     elseif Z(i,j) > mp_one
                        Z(i, j) = Inf;
                     else
                        Z(i, j) = mp_one;
                     end
                  end
               end
            end
         end
         return;
      end
      
      Ai = mp_power(A, n);
      Z = mp_add(Z, Ai);
      odp = 0;
      for i = 1:m
	       for j = 1:m
            if (Ai(i, j) ~= mp_zero)
               odp = 1;
               break
            end
         end
      end
   end
% end of file