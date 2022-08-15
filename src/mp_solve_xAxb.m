function [x] = mp_solve_xAxb(A, b)
   %   (max, +) algebraic solution of x = Ax + b
   %
   %   x = MP_SOLVE_XAXB(A, b)
   %
   %   returns vector x = A* b
   %       when there is no circuits with positive weight in graph G(A)
   %       x = (A^0 \oplus A^1 \oplus ... \oplus A^(m-1)) \otimes b
   %          where m denotes the order of the square matrix A
   %   A must be a square matrix.
   %
   %   See also
   %   MP_STAR, MP_SOLVE_AXB
   %
   %   Introduced in ver.1.02
   %
   %   Max-Plus Algebra Toolbox for Matlab, ver.1.7, 2016-June-14
   %   Copyright (C) 2016 Jaroslaw Stanczyk
   
   narginchk(2, 2);
   
   if (isempty(A) || isempty(b))
      error('mp_solve_xAxb: empty input variable')
   end
   x = mp_multi(mp_star(A), b);
% end of file
