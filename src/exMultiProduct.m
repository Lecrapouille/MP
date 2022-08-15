%   example of multi-product manufacturing system
%
%   EXMULTIPRODUCT
%
%   See also
%   exMultiProduct2, exSimpleProduction, exSimpleProduction2
%
%   Introduced in ver.1.0
%
%   Max-Plus Algebra Toolbox for Matlab, ver.1.7, 2016-June-14
%   Copyright (C) 2016 Jaroslaw Stanczyk

% matrices definition
A0 = [-inf -inf -inf -inf -inf -inf -inf
         1 -inf -inf -inf -inf -inf -inf
      -inf -inf -inf -inf -inf -inf -inf
         1 -inf    3 -inf -inf -inf -inf
      -inf    5 -inf    2 -inf -inf -inf
      -inf -inf    3 -inf -inf -inf -inf
      -inf -inf -inf    2 -inf    4 -inf ]

A1 = [-inf    5 -inf -inf -inf -inf    3
      -inf -inf -inf -inf    3 -inf -inf
      -inf -inf -inf -inf    3    4 -inf
      -inf -inf -inf -inf -inf -inf -inf
      -inf -inf -inf -inf -inf -inf -inf
      -inf -inf -inf -inf -inf -inf    3
      -inf -inf -inf -inf -inf -inf -inf ]

B0 = [   0 -inf -inf -inf    0 -inf
      -inf -inf -inf -inf -inf    0
      -inf    0 -inf    0 -inf -inf
      -inf -inf -inf -inf -inf -inf
      -inf -inf -inf -inf -inf -inf
      -inf -inf    0 -inf -inf -inf
      -inf -inf -inf -inf -inf -inf ]
 
% create the A matrix
A = mp_multi(mp_star(A0), A1);

% calculate a minimum cycle time
lambda = mp_mcm(A)

% create the B matrix
B = mp_multi(mp_star(A0), B0);

% determine initial conditions
x = mp_zeros(7, 1);
u = mp_ones(6, 1);

% calculate a sequence of a state vector
X(:, 1) = mp_add(mp_multi(A, x), mp_multi(B, u));
for i = 2:10
    X(:, i) = mp_add(mp_multi(A, X(:, i-1)), mp_multi(B, u));
end
X

% end of file