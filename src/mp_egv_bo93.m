function [eigenvector, eigenvalue] = mp_egv_bo93(A, x0, r)
   %   (max, +) eigenvector and eigenvalue
   %
   %   [eigenvector, eigenvalue] = MP_EGV_BO93(A, x0, r)
   %
   %   Function returns an eigenvector and an eigenvalue of matrix A
   %   - A is a n-by-n matrix,
   %   - x0 = x(0) is a n-by-one initial vector,
   %   - r (optional, default r=1000) is a maximum number of steps,
   %     after which algorithm stops.
   %   If A has more than one eigenvalue, function returns only one.
   %   If A has more than one eigenvector associated with the eigenvalue,
   %     function returns only one.
   %
   %   For details see:
   %       J.G.Braker G.J.Olsder (1993)
   %       "The power alghoritm in max algebra"
   %       Linear Algebra and its Applications, vol.182, pp.67-89, 1993.
   %
   %   See also
   %   MP_EGV_O91, MP_EGV_PQC, MP_EGV_SW001, MP_EGV_SW002,
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
      error('mp_egv_bo93: algorithm works for square matrix A only!');
   end
   
   sizex = size(x0);
   if (sizex(2) ~= 1)
      error('mp_egv_bo93: x0 must be a column vector!');
   end
   
   if (sizex(1) ~= sizeA(1))
      error('mp_egv_bo93: inconsistent matrices sizes');
   end
   
   if (x0 == mp_zeros(sizex))
      error('mp_egv_bo93: for this x0 algorithm does not converge!');
   end
   
   pqc = mp_pqc(A, x0, R_MAX);
   p = pqc(1);
   q = pqc(2);
   c = pqc(3);
   eigenvalue = c/(p-q);
   eigenvector = mp_system(A, x0, q);
   
   for j = 2:p-q   
      eigenvector = eigenvector + mp_system(A, x0, q + j - 1);
   end
   eigenvector = (1/(p-q)) * eigenvector;
   
   if mp_is_egv1(A, eigenvector, eigenvalue) == 0
      % the candidate eigenvector is not an eigenvector
      left = mp_multi(A, eigenvector);
   	  right = mp_multi(eigenvalue, eigenvector);
      new_v = eigenvector;
	    for i = 1:length(eigenvector)
      	 if left(i) ~= right(i)
         	  new_v(i) = -inf;
      	 end
      end   
      %new_v
      % and now we are looking for r 
      % r>=0 there holds x(r+1) = eigenvalue \otimes x(r)
      for r = 0:R_MAX
         x_r = mp_system(A, new_v, r);
         x_next_r = mp_system(A, new_v, r + 1);
         if mp_is_egv2(x_next_r, x_r, eigenvalue) == 1
            eigenvector = x_r;
            return
   	     end
      end
      error('mp_egv_bo93: number of iteration has exceed R_MAX!');
   end
% end of file