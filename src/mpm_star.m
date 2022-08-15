function [Z, n] = mpm_star(A)
   %  (min, +) star operator
   %
   %  [Z, n] = MPM_STAR(A)
   %  - Z = A* = A^0 + A^+ = A^0 + A^1 + A^2 + ...,
   %  - n - minimal value for what all entries are equal to m-p zeros,
   %  operator is defined for square matrix ONLY!
   %
   %  See also
   %  MPM_PLUS, MP_IS_PGA, MP_IS_PGC
   %
   %  Introduced in ver.1.5
   %
   %  Max-Plus Algebra Toolbox for Matlab, ver.1.7, 2016-June-14
   %  Copyright (C) 2016 Jaroslaw Stanczyk
   
   narginchk(1, 1);
   if isempty(A)
      error('mpm_star: empty input matrix')
   end
   [m, n] = size(A);
   if m ~= n
      error('mpm_star: star operator is defined for square matrix only!')
   end
   
   E = mpm_eye(m);
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
               Ai = mpm_power(A, m + 1);
               if Z(i, j) ~= mpm_zero && Z(i, j) ~= mpm_one
                  if Z(i, j) > Ai(i, j)
                     if Z(i, j) > mpm_one
                        Z(i, j) = mpm_zero;
                     elseif Z(i, j) < mpm_one
                        Z(i, j) = -Inf;
                     else
                        Z(i, j) = mpm_one;
                     end
                  end
               end
            end
         end
         return;
      end
      
      Ai  = mpm_power(A, n);
      Z = mpm_add(Z, Ai);
      odp = 0;
      for i = 1:m
         for j = 1:m
            if Ai(i, j) ~= mpm_zero
               odp = 1;
               break
            end
         end
      end
   end
% end of file