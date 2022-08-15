function [x, err] = mp_solve_Axb(A, b)
   %   (max, +) algebraic greatest subsolution of Ax = b
   %   (max, +) residuation operation
   %
   %   [x, err] = MP_SOLVAXB(A, b)
   %
   %   the greatest subsolution of Ax = b,
   %       computes the largest x such that  Ax <= b
   %       for A and b finite scalars, x = A-b (in conventional algebra)
   %       if x is the solution, then err = 0, err = 1 otherwise
   %
   %   See also
   %   MP_STAR, MP_SOLVE_XAXB
   %
   %   Introduced in ver.1.02
   %
   %   Max-Plus Algebra Toolbox for Matlab, ver.1.7, 2016-June-14
   %   Copyright (C) 2016 Jaroslaw Stanczyk
   
   narginchk(2, 2);
   
   if (isempty(A) || isempty(b))
      error('mp_solve_Axb: empty input variable')
   end
   size_b = size(b);
   
   x = mp_ones(size_b) - mp_multi((mp_ones(size_b) - b)',  A)';
   
   if mp_multi(A, x) == b
      err = 0;
   else
      err = 1;
   end
% end of file
