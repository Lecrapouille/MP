function [pqc] = mp_pqc(A, x0, r)
   %   computes parameters for an eigenvalue (and eigenvectors)
   %
   %   [pqc] = MP_PQC(A, x0, r)
   %
   %   Function calculates the components p, q, c of an eigenvalue of matrix A
   %   - A is a n-by-n matrix,
   %   - x0 = x(0) is a n-by-one initial vector,
   %   - r (optional, default r=1000) is a maximum number of steps,
   %     after which algorithm stops.
   %
   %   lambda (eigenvalue) = c / (p - q)
   %   The eigenvalue of A from the results of MP_PQC
   %   can be calculated by MP_EGV_PQC
   %
   %   pqc is a vector, i.e. pqc = [p q c],
   %   where
   %      p, q are integers: p > q >= 0,
   %      c is real, such that x(p) = x(q) \otimes c
   %
   %   See also
   %   MP_EGV_BO93, MP_EGV_O91, MP_EGV_PQC, MP_EGV_SW001, MP_EGV_SW002,
   %   MP_IS_EGV1, MP_IS_EGV2, MP_IS_PGA, MP_IS_PGSC1, MP_IS_PGSC2,
   %   MP_MCM, MP_MCM_FW, MP_MCM_KARP
   %
   %   Introduced in ver.1.0
   %
   %   Max-Plus Algebra Toolbox for Matlab, ver.1.7, 2016-June-14
   %   Copyright (C) 2016 Jaroslaw Stanczyk
   
   narginchk(2, 3);
   
   switch nargin
   case 2
      R_MAX = 1000;
   case 3
      R_MAX = r;
   end
   
   sizeA = size(A);
   if (sizeA(1) ~= sizeA(2))
      error('mp_pqc: algorithm works for square matrix A only!');
   end
   
   sizex = size(x0);
   if (sizex(2) ~= 1)
      error('mp_pqc: x0 must be a column vector!');
   end
   
   if (sizex(1) ~= sizeA(1))
      error('mp_pqc: inconsistent matrices sizes');
   end
   
   if (x0 == mp_zeros(sizex))
       error('mp_pqcC: for this x0 algorithm does not converge!');
   end
   
   for p = 1:R_MAX
      stan_p = mp_system(A, x0, p);
      for q = 0:(p-1)
         koniec = 1; % this variable is needed for chcecks:
         stan_q = mp_system(A, x0, q);
         wektor_c = stan_p - stan_q; % diference in vectors
         c = wektor_c(1, 1);
         for i = 1:sizex(1)
            if c ~= wektor_c(i, 1)
               koniec = 0;
            end
         end
         if koniec == 1
           pqc = [p q c];
           return
         end
      end
   end
   if (koniec == 0)
      error('mp_pqc: number of iteration has exceed R_MAX!');
   end
% end of file