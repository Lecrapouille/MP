%   generates Gantt chart using mp_ganttr
%
%   EXGANTTR
%
%   Values of state vector and operation times are taken from exMultiProduct.m
%
%   See also
%   MP_GANTTX, MP_GANTTR,
%   EXGANTTX
%
%   Introduced in ver.1.0
%
%   Max-Plus Algebra Toolbox for Matlab, ver.1.7, 2016-June-14
%   Copyright (C) 2016 Jaroslaw Stanczyk

X = [0    10    19    29    38    48    57    67    76    86;
     1    11    20    30    39    49    58    68    77    87;
     0     9    19    28    38    47    57    66    76    85;
     3    12    22    31    41    50    60    69    79    88;
     6    16    25    35    44    54    63    73    82    92;
     3    12    22    31    41    50    60    69    79    88;
     7    16    26    35    45    54    64    73    83    92];

% operation times
t = [1 5 3 2 3 4 3]';

% matrix of resources-state-vector connection   
R = [[1 2 0]; [3 4 5]; [6 7 0]];

figure(1);
mp_ganttr(X(:, 1:8), t, R);

% end of file