%   example of multi-product manufacturing system
%
%   EXMULTIPRODUCT2
%
%   See also
%   exMultiProduct, exSimpleProduction, exSimpleProduction2
%
%   Introduced in ver.1.02
%
%   Max-Plus Algebra Toolbox for Matlab, ver.1.7, 2016-June-14
%   Copyright (C) 2016 Jaroslaw Stanczyk

% operation times
d = [1 5 3 2 3 4 3]

% matrices definition
A0 = mp_zeros(7);
A0(2,1) = d(1); A0(4,1) = d(1); A0(4,3) = d(3); A0(5,2) = d(2);
A0(5,4) = d(4); A0(6,3) = d(3); A0(7,4) = d(4); A0(7,6) = d(6);
A0

A1 = mp_zeros(7);
A1(1,2) = d(2); A1(1,7) = d(7); A1(2,5) = d(5);
A1(3,5) = d(5); A1(3,6) = d(6); A1(6,7) = d(7);
A1

B0 = mp_zeros(7,6);
B0(1,1) = mp_one; B0(1,5) = mp_one; B0(2,6) = mp_one;
B0(3,2) = mp_one; B0(3,4) = mp_one; B0(6,3) = mp_one;
B0

C = mp_zeros(6,7);
C(1,2) = d(2); C(2,3) = d(3); C(3,7) = d(7);
C(4,6) = d(6); C(5,7) = d(7); C(6,5) = d(5);
C

K = mp_eye(6);
K

% create the matrices A=(A0^*A1) and B=(A0^*B0)
A = mp_multi(mp_star(A0), A1)
B = mp_multi(mp_star(A0), B0)

% create matrix M = (A \oplus BKC)
M = mp_add(A, mp_multi(B, mp_multi(K, C)))

% determine initial conditions
x0 = mp_zeros(7, 1)
u1 = mp_ones(6, 1)

% calculate a sequence of a state vector
X(:, 1) = mp_add(mp_multi(A, x0), mp_multi(B, u1));
for i = 2:10
    X(:, i) = mp_multi(M, X(:, i - 1));
end
X

% calculate a sequence of an output vector
Y = mp_multi(C, X)

% cycle time
lambda = mp_mcm(M)

% does the system start in steady-state?
mp_is_egv1(M, X(:, 1), lambda)

% "0" means NO, so, let us calculate new x0 for start in steady state
x0 = mp_egv_sw001(M, mp_ones(7, 1))

% let min(x0) == 0
x0 = x0 - min(x0);

% calculate a new sequence of a state vector
X(:, 1) = x0;
for i = 2:10
    X(:, i) = mp_multi(M, X(:, i-1));
end
X

% calculate others preformance indices
% resources utilisation level (for M1, M2, M3 respectively):
ro = [d(1)+d(2) d(3)+d(4)+d(5) d(6)+d(7)] / lambda

% processes execution level (P1, P2, P3):
eta = [d(3)+d(6) d(1)+d(4)+d(7) d(2)+d(5)] / lambda

% end of file