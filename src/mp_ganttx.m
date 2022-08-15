function  mp_ganttx(X, t, xrange, ytick)
   %   Gantt chart of a state vector evolution in time
   %   Gantt chart of execution of operations
   %
   %   MP_GANTTX(X, time, xrange, ytick)
   %
   %   A Gantt chart of a state vector evolution in time 
   %      or execution of operations:
   %   - X is a n-by-m matrix of state vectors 
   %       i.e. a collection of m successive state-vectors
   %       (every column is one state vector)
   %   - t (time) is a n-by-1 vector with operation times 
   %       for every entry in state vector (time of every event/operation)
   %       or 
   %       n-by-m matrix of operation times for m iterations
   %       (time of every event/operation in every iteration)
   %   - xrange (optional) enables you to specify limits of x axis,
   %       xrange = [xmin xmax]
   %       by default, function finds the maxima and minima of the data 
   %       (i.e. xmin = min(X), xmax = max(X+t));
   %   - ytick (optional) ytick = 0|1 (default ytick=1) 
   %       if ytick=1 then every ytick is marked along y axis.
   %
   %   See also
   %   MP_GANTTR
   %
   %   Introduced in ver.1.0
   %
   %   Max-Plus Algebra Toolbox for Matlab, ver.1.7, 2016-June-14
   %   Copyright (C) 2016 Jaroslaw Stanczyk
   
   narginchk(2, 4);
   
   switch nargin
      case 2
         xsize = checkVar(X,t);
         [xmin, xmax, ymin, ymax, yt] = setDef(X, t, xsize);
         
      case 3
         xsize = checkVar(X,t);
         [xmin, xmax, ymin, ymax, yt] = setDef(X,t,xsize);
         rangesize = size(xrange);
         if (rangesize(1) == 1) && (rangesize(2) == 1)
            yt = xrange;
         elseif (rangesize(1) == 1) && (rangesize(2) == 2)
            xmin = xrange(1);
            xmax = xrange(2);
         else
            error('mp_ganttx: wrong parameters of axes range')
         end
      
      case 4
         xsize = checkVar(X,t);
         [xmin, xmax, ymin, ymax, yt] = setDef(X,t,xsize);
         rangesize = size(xrange);
         if (rangesize(1) == 1) && (rangesize(2) == 2)
            xmin = xrange(1);
            xmax = xrange(2);
         else
            error('mp_ganttx: wrong parameters of axes range')
         end
         yt = ytick;
   end
   
   color = ['g' 'b' 'm' 'c' 'r' 'k'];
   grid on;
   tsize = size(t);
   if tsize(2) == 1
      tl = t;
   end
   
   for line = 1:xsize(1)
      for j = 1:(xsize(2))
         if tsize(2) > 1
            tl = t(:, j);
         end
         rectangle('Position', [ X(line,j) line tl(line) 0.7 ], 'FaceColor', color(mod(j,6)+1));
      end
   end
   
   if yt == 1
      set(gca,'YTick',[1:1:ymax]);
   end
   
   axis([xmin xmax ymin ymax]);
   xlabel('time');
   ylabel('events');

function [xmin, xmax, ymin, ymax, yt] = setDef(X, t, xsize)
   % set default values for main variables
   xmin = min(X(:, 1));
   tsize = size(t);
   if tsize(2) == 1
      xmax = max(X(:, xsize(2)) + t);
   else
      xmax = max(X(:, xsize(2)) + t(:, xsize(2)));
   end
   ymin = 1;
   ymax = xsize(1) + 1;
   yt   = 1;

function xsize = checkVar(X, t)
   if isempty(X)
      error('mp_ganttx: a matrix of state vectors is empty!');
   end
   if isempty(t)
      error('mp_ganttx: a time vector is empty!');
   end
   xsize = size(X);
   tsize = size(t);
   if xsize(1) ~= tsize(1)
      error('mp_ganttx: inconsistent X and t sizes');
   end
   if ((tsize(2) ~= 1) && (tsize(2) ~= xsize(2)))
      error('mp_ganttx: inconsistent X and t sizes');
   end
% end of file