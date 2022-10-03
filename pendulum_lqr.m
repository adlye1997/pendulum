function pendulum()
clc;
clear;
fprintf("一阶直线倒立摆\n");

syms x dx ddx;
syms theta dtheta ddtheta;
syms m M l g;
syms F Fx Fz;

m = 1;
M = 1;
l = 1;
g = 9.81;

f1 = F - Fx - M * ddx;
f2 = Fx - m * ddx - 0.5 * m * l * ddtheta;
f3 = Fz - m * g;
f4 = 0.5 * Fz * l * theta - 0.5 * Fx * l - m * l * l * ddtheta / 12;

[ddx_solve, ddtheta_solve, ~, ~] = solve(f1, f2, f3, f4, ddx, ddtheta, Fx, Fz);


A = [0, 1, 0, 0;
     0, 0, diff(ddx_solve,theta), 0;
     0, 0, 0, 1;
     0, 0, diff(ddtheta_solve, theta), 0];
B = [0; diff(ddx_solve, F); 0; diff(ddtheta_solve, F);];
C = [1, 0, 0, 0;
     0, 0, 1, 0];
D = zeros(size(C, 1), size(B, 2));
Q = [1, 0, 0, 0;
     0, 1, 0, 0;
     0, 0, 1, 0;
     0, 0, 0, 1];
R = 0.1;

A = double(A);
B = double(B);
K = lqr(A,B,Q,R)

