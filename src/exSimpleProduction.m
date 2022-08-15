%   example of simple manufacturing system
%
%   EXSIMPLEPRODUCTION
%
%   See also
%   exSimpleProduction2, exMultiProduct, exMultiProduct2
%
%   Introduced in ver.1.0
%
%   Max-Plus Algebra Toolbox for Matlab, ver.1.7, 2016-June-14
%   Copyright (C) 2016 Jaroslaw Stanczyk

clear
disp(' ');
disp('a simple production system');
disp('--------------------------');

t1 = 2;
t2 = 0;
t3 = 1;
t4 = 0;
t5 = 0;

d1 = 5;
d2 = 6;
d3 = 3;

% number of iteration
K = 10;

A0 = ones(3, 3) * -inf;
A0(3, 1) = mp_multi(t3, d1);
A0(3, 2) = mp_multi(t4, d2);

A1 = ones(3, 3) * -inf;
A1(1, 1) = d1;
A1(2, 2) = d2;
A1(3, 3) = d3;

B0 = ones(3, 1) * -inf;
B0(1) = t1;
B0(2) = t2;

A = mp_multi(mp_star(A0), A1)
B = mp_multi(mp_star(A0), B0)

C = ones(1, 3) * -inf;
C(1, 3) = mp_multi(t5, d3);
C

clear t1 t2 t3 t4 t5
%clear d1 d2 d3
%clear A0 A1 B0

x0 = ones(3, 1) * -inf

disp('-> press any key <-')
pause
disp(' ')

disp('first approach');
disp('--------------');

disp('u = 0 = const');
u = 0;

X(:, 1) = mp_add(mp_multi(A, x0), mp_multi(B, u));
Y(1) = mp_multi(C, X(:, 1));
for i = 2:K
    X(:, i) = mp_add(mp_multi(A, X(:, i-1)), mp_multi(B, u));
    Y(i) = mp_multi(C, X(:, i));
end
X
Y

clear X Y
disp('-> press any key <-')
pause
disp(' ')

disp('second approach');
disp('---------------');
u = 0;
disp('start of the system with u(1) = 0, then u(k+1) = y(k)');

X(:, 1) = mp_add(mp_multi(A, x0), mp_multi(B, u));
Y(1) = mp_multi(C, X(:, 1));
for i = 2:K
    X(:,i) = mp_add(mp_multi(A, X(:, i-1)), mp_multi(B, Y(i-1)));
    Y(i) = mp_multi(C, X(:, i));
end
X
Y

clear X Y

%example, where new matrix A_ = A \oplus (B \otimes C)
%disp('u(1) = 0 for start the system, with new A_ matrix');

%A_ = mp_add(A, mp_multi(B, C))

%initial condition
%X(:, 1) = mp_multi(B, u);
%Y(1) = mp_multi(C, X(:, 1));

%for i = 2:K
%    X(:, i) = mp_multi(A_, X(:, i-1));
%    Y(i) = mp_multi(C, X(:, i));
%end
%X
%Y
%clear X Y
%clear A_

[lambda, d] = mp_mcm(A)

%clear A B C
clear x u
clear K i
clear d1 d2 d3

% end of file