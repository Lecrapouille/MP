% Max-Plus Algebra Toolbox for Matlab, ver.1.7, 2016-June-14
%
% Copyright (C) 2016 Jaroslaw Stanczyk
% http://gen.up.wroc.pl/stanczyk/mpa/
%
% Files
%   exGanttr            - generates Gantt chart using mp_ganttr
%   exGanttx            - generates Gantt charts using mp_ganttx
%   exMultiProduct      - example of multi-product manufacturing system
%   exMultiProduct2     - example of multi-product manufacturing system
%   exSimpleProduction  - example of simple manufacturing system
%   exSimpleProduction2 - example of simple manufacturing system
%   mp_add              - (max, +) addition
%   mp_conv             - conversion scalar, vector or matrix from (max,+) to (min,+) and vice versa
%   mp_div              - (max, +) division
%   mp_egv_bo93         - (max, +) eigenvector and eigenvalue
%   mp_egv_o91          - (max, +) eigenvector (candidate) and eigenvalue
%   mp_egv_pqc          - eigenvalue form components p, q, and c
%   mp_egv_sw001        - (max, +) eigenvector and eigenvalue
%   mp_egv_sw002        - (max, +) eigenvector and eigenvalue
%   mp_ev_fw            - matrix of eigenvectors from A matrix
%   mp_eye              - (max, +) identity matrix
%   mp_ganttr           - Gantt chart of resources occupation in time
%   mp_ganttx           - Gantt chart of a state vector evolution in time
%   mp_inv              - (max, +) invertion of scalar, vector or matrix
%   mp_is_egv1          - function chcecks, whether a vector x is an eigenvector of A
%   mp_is_egv2          - chcecks: lambda^d \otimes x1 == x2
%   mp_is_pga           - is precedence graph associated with A acyclic?
%   mp_is_pgc           - is precesdece graph connected?
%   mp_is_pgsc1         - is precedence graph strongly connected?
%   mp_is_pgsc2         - is precedence graph strongly connected?
%   mp_mcm              - maximum cycle mean of precedence graph G(A)
%   mp_mcm_fw           - (max, +) eigenvalue
%   mp_mcm_karp         - (max, +) eigenvalue of A
%   mp_multi            - (max, +) multiplication
%   mp_mx2latex         - matrix conversion from max-plus description to the LaTeX
%   mp_mx_fw            - (max, +) Floyd-Warshall matrix
%   mp_one              - (max, +) unit (0)
%   mp_ones             - (max, +) ones array
%   mp_power            - (max, +) power of X (scalar or square matrix) to n
%   mp_pqc              - computes parameters for an eigenvalue (and eigenvectors)
%   mp_randi            - (max, +) random integer + mp_zero (-Inf)
%   mp_solve_Axb        - (max, +) algebraic greatest subsolution of Ax = b
%   mp_solve_xAxb       - (max, +) algebraic solution of x = Ax + b
%   mp_star             - (max, +) star operator
%   mp_system           - state of an autonomous linear max-plus system (state-space model)
%   mp_trace            - (max, +) trace of a matrix
%   mp_zero             - (max, +) zero (-Inf)
%   mp_zeros            - (max, +) zeros array
%   mpm_add             - (min, +) addition
%   mpm_div             - (min, +) division
%   mpm_eye             - (min, +) identity matrix
%   mpm_inv             - (min, +) invertion of scalar, vector or matrix
%   mpm_multi           - (min +) multiplication
%   mpm_mx2latex        - matrix conversion from min-plus to the LaTeX
%   mpm_one             - (min, +) algebraic unit (0)
%   mpm_ones            - (min, +) ones array
%   mpm_plus            - (min, +) plus operator.
%   mpm_power           - (min, +) power of X (scalar or square matrix) to n
%   mpm_star            - (min, +) star operator
%   mpm_zero            - (min, +) zero (Inf)
%   mpm_zeros           - (min, +) zeros array
