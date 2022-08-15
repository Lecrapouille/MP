function  mp_ganttr(X, t, R, xrange, ytick)
   %   Gantt chart of resources occupation in time
   %
   %   MP_GANTTR(X, time, Rsv, xrange, ytick)   
   %
   %   A Gantt chart of resources occupation in time, where
   %   - X is an n-by-m matrix of state vectors
   %       i.e. a collection of m successive state vectors
   %       (every column is one state vector)
   %   - time is a n-by-1 vector
   %       with operation times for every entry in state vector
   %       (time of every event/operation)
   %       or a n-by-m matrix of operation times for m iterations
   %       (time of every event/operation in every iteration)
   %   - Rsv is an k-by-p matrix of resources-state-vector connection
   %       k is number of resources in system,
   %       p is maximal amount of elements of state-vector for resource
   %         i.e. which entries of state-vector responds for which resource, 
   %         see exGanttr.m for details;
   %   - xrange (optional) enables to specify limits of x axis,
   %       xrange = [xmin xmax],
   %       by default, function finds the maxima and minima of the data
   %       ( i.e. xmin = min(X), xmax = max(X+t) )
   %   - ytick (optional, default ytick=1) ytick = 0 | 1
   %       if ytick=1 then every ytick is marked along y axis
   %
   %   See also
   %   MP_GANTTX
   %
   %   Introduced in ver.1.0
   %
   %   Max-Plus Algebra Toolbox for Matlab, ver.1.7, 2016-June-14
   %   Copyright (C) 2016 Jaroslaw Stanczyk
   
   narginchk(3, 5);
   
   switch nargin
      case 3
         [rsize, xsize] = checkVar(X, t, R);
         [xmin, xmax, ymin, ymax, yt] = setDef(X, t, rsize, xsize);
      case 4
         [rsize, xsize] = checkVar(X, t, R);
         [xmin, xmax, ymin, ymax, yt] = setDef(X, t, rsize, xsize);
         
         rangesize = size(xrange);
         if (rangesize(1) == 1) && (rangesize(2) == 1)
            yt = xrange;
         elseif (rangesize(1) == 1) && (rangesize(2) == 2)
            xmin = xrange(1);
            xmax = xrange(2);
         else
            error('mp_ganttr: wrong parameters of axes range')
         end
      case 5
         [rsize, xsize] = checkVar(X, t, R);
         [xmin, xmax, ymin, ymax, yt] = setDef(X, t, rsize, xsize);

         rangesize = size(xrange);
         if (rangesize(1) == 1) && (rangesize(2) == 2)
            xmin = xrange(1);
            xmax = xrange(2);
         else
            error('mp_ganttr: wrong parameters of axes range')
         end
         yt = ytick;
   end
   
   % utworz nowa maceirz X1 zbudowana wg. zasad przedstawionych w R
   % i jesli beda na siebie nachodzic - daj ostrzezenie
   X1 = ones(rsize(1), xsize(2), rsize(2)) * -inf;
   % X1(:,:,n) - start operacji z n-tej kolumny macierzy R
   t1 = ones(rsize(1), rsize(2), xsize(2)) * -inf;
   % t1(:,n) - czas operacji z n-tej kolumny macierzy R dla op. startujacej w X1(:,:,n)
   
   tsize = size(t);
   if tsize(2) == 1
      tt = t;
   end
   
   % wypelnienie t1
   for i = 1:rsize(1)
      for j = 1:rsize(2)
         for k = 1:xsize(2)
            if tsize(2) > 1
               tt = t(:, k);
            end
            if R(i, j) > 0
               t1(i, j, k) = tt(R(i, j));
            end
         end
      end
   end
   
   % wypelnienie X1
   for i = 1:rsize(1)
      for j = 1:rsize(2)
         if R(i, j) > 0
            X1(i, :, j) = X(R(i, j), :);
         end
      end
   end
   x1size = size(X1);
   
   % sprawdzenie czy operacje na tym samym zasobie sie nie nakladaj
   % (beda sie nakladaly, gdy dostep jest typu rendezvous!)
   % no i wreszcie rysowanie
   color = ['g' 'b' 'm' 'c' 'r' 'k'];
   grid on;
   for line = 1:x1size(1)
      for j = 1:x1size(2)
         for k = 1:x1size(3)
            if (X1(line, j, k) > -inf)
              rectangle('Position', [ X1(line, j, k) line t1(line, k, j) 0.7 ], 'FaceColor', color(mod(j, 6) + 1));
            end
         end
      end
   end
   if yt == 1
     set(gca, 'YTick', [1:1:ymax]);
   end
   axis([xmin xmax ymin ymax]);
   xlabel('time');
   ylabel('resources');

function [xmin, xmax, ymin, ymax, yt] = setDef(X, t, rsize, xsize)
   % set default values for main variables
   xmin = min(X(:, 1));
   
   tsize = size(t);
   if tsize(2) == 1
      xmax = max(X(:, xsize(2)) + t);
   else
      xmax = max(X(:, xsize(2)) + t(:, xsize(2)));
   end
   
   ymin = 1;
   ymax = rsize(1) + 1;
   yt   = 1;

function [rsize,xsize] = checkVar(X, t, R)
   if isempty(X)
      error('mp_ganttr: a matrix of state vectors is empty!');
   end
   
   if isempty(t)
      error('mp_ganttr: a time vector is empty!');
   end
   
   if isempty(R)
      error('mp_ganttr: a matrix of resources-state-vector is empty!');
   end
   
   xsize = size(X);
   tsize = size(t);
   if xsize(1) ~= tsize(1)
      error('mp_ganttr: inconsistent X and t sizes');
   end
   
   if ((tsize(2) ~= 1) && (tsize(2) ~= xsize(2)))
      error('mp_ganttr: inconsistent X and t sizes');
   end
   
   rsize = size(R);
% end of file