%   generates Gantt charts using mp_ganttx
%
%   EXGANTTX
%
%   See also
%   MP_GANTTX, MP_GANTTR,
%   EXGANTTR
%
%   Introduced in ver.1.0
%
%   Max-Plus Algebra Toolbox for Matlab, ver.1.7, 2016-June-14
%   Copyright (C) 2016 Jaroslaw Stanczyk

% first Gantt chart
% -------------------
% input variables:
% collections of 4 state vectors
X1 = [  -Inf          14        1454        2894;
        -Inf         201        1641        3081;
        -Inf         374        1814        3254;
        -Inf         471        1911        3351;
        -Inf         350        1790        3230;
        -Inf         566        2006        3446;
        -Inf         663        2103        3543;
        -Inf         861        2301        3741;
        -Inf           0        1440        2880;
        -Inf         511        1951        3391;
        -Inf         421        1861        3301;
        -Inf         402        1842        3282;
        -Inf         546        1986        3426;
        -Inf         168        1608        3048;
        -Inf         572        2012        3452;
        -Inf         930        2370        3810;
        -Inf        1229        2669        4109;
        -Inf         314        1754        3194;
        -Inf         976        2416        3856;
        -Inf         960        2400        3840;
        -Inf         721        2161        3601;
        -Inf         367        1807        3247;
        -Inf         535        1975        3415;
        -Inf         331        1771        3211];

% operation times    
times = [172;
         168;
          87;
         221;
         208;
          88;
         173;
         199;
         178;
         179;
         658;
         626;
         236;
         206;
         336;
         294;
         225;
         250;
         531;
         539;
         160;
         165;
         386;
         321];

figure(1);
mp_ganttx(X1(:, 2:4), times, [0 4000], 0);

% second chart
X2 = [    14        1060        2196        2762
         201        1232        2368        2934
         374        1400        2536        3102
         471        1487        2623        3189
         350         692        1708        2844
         566        1736        2302        3052
         663        1824        2390        3140
         861        1997        2563        3313
           0         690        1413        2549
         511        1234        2370        2936
         421        1402        2538        3104
         402        1079        2060        3196
         546        1489        2625        3191
         168         782        1725        2861
         572        1734        2300        3054
         930        1501        2070        3144
        1229        1795        2364        3438
         314        1484        2050        2619
         976        2072        2638        3392
         960        1507        2603        3169
         721        1826        2392        3142
         367         881        1986        2552
         535        1046        2151        2717
         331         921        1432        2537];

figure(2);
mp_ganttx(X2, times, [0 4000], 0);  
%mp_ganttx(X2(:, 2:4), times);

% different calls of mp_gantt for this same data
figure(3);
subplot(2, 2, 1); mp_ganttx(X1(:, 2:4), times);
subplot(2, 2, 2); mp_ganttx(X1(:, 2:4), times, 0);
subplot(2, 2, 3); mp_ganttx(X1(:, 2:4), times, [0 3000]);
subplot(2, 2, 4); mp_ganttx(X1(:, 2:4), times, [0 3000], 0);

% end of file