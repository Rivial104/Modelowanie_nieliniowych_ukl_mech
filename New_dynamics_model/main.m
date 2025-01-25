clc;clear;

n = 3; % Liczba członów
L = lagrange_f(n);

disp('Funkcja Lagrange’a:');
disp(L);

eq = lagrange_eq(L, n);

disp('Równania Lagrange’a dla theta_i:');
disp(eq.theta);

disp('Równanie Lagrange’a dla xDot:');
disp(eq.xDot);

disp('Równanie Lagrange’a dla yDot:');
disp(eq.yDot);
