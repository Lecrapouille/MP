function [l] = mp_egv_pqc(p, q, c)
   %   eigenvalue form components p, q, and c
   %   
   %   [eigenvalue] = MP_EGV_PQC(p, q, c)
   %   [eigenvalue] = MP_EGV_PQC([p q c])
   %
   %
   %   Function returns an eigenvalue
   %       eigenvalue = c / (p-q)
   %           p and q are integers: p > q >= 0
   %           c is real number, (such that x(p) = x(q) \otimes c)
   %
   %   See also 
   %   MP_PQC, MP_EGV_BO93, MP_EGV_O91, MP_EGV_SW001, MP_EGV_SW002,
   %   MP_IS_EGV1, MP_IS_EGV2, MP_IS_PGA, MP_IS_PGSC1, MP_IS_PGSC2,
   %   MP_MCM, MP_MCM_FW, MP_MCM_KARP
   %
   %   Introduced in ver.1.0
   %
   %   Max-Plus Algebra Toolbox for Matlab, ver.1.7, 2016-June-14
   %   Copyright (C) 2016 Jaroslaw Stanczyk
   
   narginchk(1, 3);
   
   switch nargin 
   case 1
      w = p;
   case 3
      w = [p q c];
   otherwise
      error('mp_egv_pqc: wrong number of parameters!')
   end
   
   si = size(w);
   if si(1,1) ~= 1
      error('mp_egv_pqc: wrong number of parameters!')
   end
   
   if si(1,2) ~= 3
      error('mp_egv_pqc: wrong number of parameters!')
   end
   
   if w(1) <= w(2) 
      error('mp_egv_pqc: p must be greater than q!');
   end
   
   if w(2) < 0
      error('mp_egv_pqc: q must be greater or equal to zero!')
   end
   
   l = w(3)/(w(1)-w(2));
% end of file