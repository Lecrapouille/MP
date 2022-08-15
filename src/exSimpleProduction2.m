%   example of simple manufacturing system
%
%   EXSIMPLEPRODUCTION2
%
%   See also
%   exSimpleProduction, exMultiProduct, exMultiProduct2
%
%   Introduced in ver.1.02
%
%   Max-Plus Algebra Toolbox for Matlab, ver.1.7, 2016-June-14
%   Copyright (C) 2016 Jaroslaw Stanczyk

disp('definition of matrices')
A = [5 mp_zero mp_zero; mp_zero 6 mp_zero; 11 12 3]
B = [2 0 8]'
C = [mp_zeros mp_zeros 3]

disp('create a new matrix Ah = A + BC')
Ah = mp_add(A, mp_multi(B, C))

% calculate a minimal cycle time
lambda = mp_mcm(Ah)

% determine initial conditions
x0 = mp_zeros(3, 1);
u0 = 0;

% calculate a sequence of state vector
X(:, 1)= mp_add(mp_multi(A, x0), mp_multi(B, u0));
Y(1)  = mp_multi(C, X(:, 1));
for i = 2:10
    X(:,i) = mp_multi(Ah, X(:, i-1));
    Y(i) = mp_multi(C, X(:, i));
end
X, Y

% end of file