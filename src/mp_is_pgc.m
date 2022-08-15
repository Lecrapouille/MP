function [c] = mp_is_pgc(A)
   %   is precesdece graph connected?
   %
   %   MP_IS_PGC(A)
   %
   %   Return 1 if precedence graph G(A) is connected, 0 otherwise
   %   A must be a square matrix
   %
   %   See also
   %   MP_IS_PGA, MP_IS_PGSC1, MP_IS_PGSC2
   %
   %   Introduced in ver.1.0
   %
   %   Max-Plus Algebra Toolbox for Matlab, ver.1.7, 2016-June-14
   %   Copyright (C) 2016 Jaroslaw Stanczyk
   
   narginchk(1, 1);
   if isempty(A)
      error('mp_is_pgc: empty input value');
   end
   
   sizeA=size(A);
   if sizeA(1, 1) ~= sizeA(1, 2)
      error('mp_is_pgc: inconsistent matrix size');
   end
   
   n = sizeA(1, 1);
   for i = 1:n
      A(i, i) = 0;
      for j = 1:n
         if A(j, i) > mp_zero()
            A(j, i) = 0;
            A(i, j) = 0;
         end
      end
   end
   
   for i = 1:n
      if A(i, 1) > mp_zero()
         for j = 1:n
            if A(j, i) > mp_zero()
               A(j, 1) = 0;
            end
         end
      end
   end
   
   for i = 1:n
      if A(i, 1) == mp_zero()
         c = 0;
         return
      end
   end
   c = 1;
% end of file