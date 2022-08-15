function mp_mx2latex(X, fileName)
   %   matrix conversion from max-plus description to the LaTeX
   %
   %   MP_MX2LATEX(X, fileName)
   %   - X is an matrix or vector,
   %   - fileName (optional) a file for source latex code, default: mp_mx.tex
   %
   %   See also
   %   MPM_MX2LATEX, MP_CONV
   %
   %   Introduced in ver.1.0
   %
   %   Max-Plus Algebra Toolbox for Matlab, ver.1.7, 2016-June-14
   %   Copyright (C) 2016 Jaroslaw Stanczyksum
   
   narginchk(1, 2);
   
   switch nargin
      case 1
         if (isempty(X))
            error('mp_mx2latex: an empty input parameter')
         end
         fileName = 'mp_mx.tex';
   end
   
   SizeX = size(X);
   fid = fopen(fileName, 'w+');
   fprintf(fid, '\\left[\n\\begin{array}{*{20}c}\n');
   for i = 1:SizeX(1, 1)
      for j = 1:SizeX(1, 2)
         if X(i, j) == -inf
            fprintf(fid, '\\varepsilon');
            % elseif X(i, j) == 0
            % fprintf(fid, 'e');
         elseif X(i, j) == inf
            fprintf(fid, '\\infty');
         else
            fprintf(fid, '%d', X(i, j));
         end
         if j < SizeX(1, 2)
            vfprintf(fid, ' & ');
         end
      end
      fprintf(fid, ' \\\\\n');
   end
   fprintf(fid, '\\end{array}\n \\right]\n');
   fclose(fid);
% end of file