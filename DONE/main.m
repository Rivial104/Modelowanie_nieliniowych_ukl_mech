% Program do wyznaczania równań ruchu robota-węża
% Autor - Paweł Zawadzki
clc;clear;

% Parametry układu
n = 6;                % Liczba członów
L = 0.4;              % Długość pręta [m]
m = 1;                % Masa członu [kg]
I = 0.4;                % Moment bezwładności [kg*m]
R = 0.1;
dt = 0.05;             % Czas korku symulacji [s]
t_k = 2;            % Czas całkowity symulacji

dxy = 0.3;
dtheta = 0.6;
dphi = 0.2;

scale = 2; % Skala osi wykresu

% Metoda Baumbartego
alpha=30;
beta=100;

% Współrzędne głowy robota
r = [0; 0];
r_dot = [2; 1];

% Orientacja początkowa członów
theta_init = linspace(0, pi/2, n);
% theta_init = zeros(n,1);

phi = zeros(n,1);
 
% Prędkości kątowe
theta_dot = 0*ones(n,1);

tau = -1*ones(n,1);
tau(1)=-3; 
E = eye(n); % Przykładowa macierz sterowania
% E(1,1) = 1;

% Początkowa inicjalizacja położenia robota (orientacja, współrzedne
% przegubów, współrzędne środków mas)
[q, p, cm] = initialize_q(n,L,r,theta_init);

% Zmienne do wymuszenia thetaDot
Amp = pi/120;
om = 6*pi;

% Parametry siły zewnętrznej
F_external = [0;0];
f_interval=0.5;

% Animacja
handles = [];

t=0:dt:t_k;
% disp(t);

% Zmienna do przechowywania wartości normy równań więzów
constraint_norm_values = zeros(length(t));

 for k = 1:length(t)

    % % Debugging
    % disp("r_dot: ")
    % disp(r_dot);
    % disp("theta_dot: ")
    % disp(theta_dot);

    [A,B,H] = compute_A_B_H(n,q,L);
    [M,C,D] = compute_M_C_D(n,m,L,I,dphi,dtheta,dxy,q,theta_dot);
    [M_t,C_t,D_t] = reduce_matrices(H,M,C,D); 
    % E = 

    % Stabilizacja Baumgarta
    % lambda = -alpha * constraint_eqation - beta * J * q;
    % stabilizing_term = J' * lambda;

    % Obliczanie przyspieszenia liniowego r_ddot
    % external_force = [0; 0];
    % if mod(t(k), f_interval) < dt
    %     external_force = F_external; % Dodanie impulsu siły bocznej
    % end

    % Aktualizacja głowy węża (r)
    % f_r_ddot = @(t, r_dot) solve_motion(M_t,C_t,D_t,H,E,tau,r_dot);
    r_ddot = M_t \ (H' * E * tau - (C_t + D_t) * r_dot); % + F_external);% + stabilizing_term;

    % r_dot = rk4_step(t(k),r_dot,dt,f_r_ddot);
    r_dot = r_dot + r_ddot*dt;
    theta_dot = H * r_dot; 
    % theta_dot = theta_dot + Amp*sin(om*t(k));

     
    % Sprawdzenie czy więzy są naruszone
    J = [eye(n), -H];
    constraint_eqation = J * [theta_dot; r_dot];
    normEq = norm(constraint_eqation);
    if normEq > 1e-5
        fprintf('Naruszenie więzów w t = %.2f: %.5f\n', t(k), normEq);
    end
 
    % % Wymuszenie na theta
    % theta1_ext = Amp*sin(om*t(k));
    % if (theta1_ext < 0)
    %     theta1_ext = theta1_ext*2;
    % end 

    disp("Constraint equation value: ")
    disp(normEq);
    constraint_norm_values(k) = normEq;

    % Korekcja przez projekcje
    J = [eye(n), -H];
    correction = pinv(J)*(J*[theta_dot;r_dot]);
    theta_dot=theta_dot - correction(1:n);
    r_dot = r_dot - correction(n+1:n+2);

    % q(1) = q(1) + theta1_ext;
    theta = q(1:n) + theta_dot * dt;
    r = r + r_dot*dt;

    % Aktualizacja q
    q(1:n) = theta(1:n);
    q(n+1:n+2) = r;

    % Wyznaczenie nowych punktów przegubowych i CM
    [~, p, cm] = initialize_q(n, L, r, theta); % Aktualizacja q, p, cm

    % Rysowanie
    handles = draw_system(n, cm, p, t(k), scale, handles);
    
    pause(dt);
 end

 plot(t, constraint_norm_values);
