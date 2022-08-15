function [Z, err] = mpm_inv(A)
   %  (min, +) invertion of scalar, vector or matrix
   %
   %  [Z,err] = MPM_INV(A)
   %  where:
   %    Z = A^(-1),
   %     err = 0 iff AZ = ZA = I, otherwise err = 1.
   %   for not square matrix A:
   %     Z = (I-A)'
   %     err = 0 iff AZ = I, otherwise err = 1.
   %
   %   See also
   %   MPM_POWER, MPM_MULTI, MPM_DIV, MPM_EYE
   %
   %   Introduced in ver.1.5
   %
   %   Max-Plus Algebra Toolbox for Matlab, ver.1.7, 2016-June-14
   %   Copyright (C) 2016 Jaroslaw Stanczyk

   narginchk(1, 1);

   err = 0;
   if isempty(A)
      Z = A;
      return
   end
   
   Z = mp_conv(-A');
   
   % checking
   sizea = size(A);
   C = mpm_multi(A, Z);
   if C == mpm_eye(size(C))
      err = 0;
   else
      err = 1;
      return
   end
   
   if sizea(1) ~= sizea(2)
      return
   end
   
   C = mpm_multi(Z, A);
   if C == mpm_eye(size(C))
      err = 0;
   else
      err = 1;
   end
% end of file