function eq = lagrange_eq(L, n)
    % Wejścia:
    % L - funkcja Lagrange'a
    % n - liczba członów
    
    syms t real            % Czas
    syms theta(t) [1 n]    % Definicja theta jako funkcji czasu
    thetaDot = diff(theta, t);  % Pochodne theta
    thetaBis = diff(thetaDot, t); % Drugie pochodne theta
    syms xDot(t) yDot(t)   % Definicja xDot i yDot jako funkcji czasu

    % Inicjalizacja macierzy wyników
    lagrange_eqs_theta = sym(zeros(1, n)); % Równania dla theta_i
    lagrange_eqs_xDot = sym(0);           % Równanie dla xDot
    lagrange_eqs_yDot = sym(0);           % Równanie dla yDot

    % Równania dla theta_i
    for i = 1:n
        dLdthetaDot = diff(L, thetaDot(i));        % ∂L / ∂thetaDot_i
        dLdthetaDot_dt = diff(dLdthetaDot, t);    % d/dt (∂L / ∂thetaDot_i)
        dLdtheta = diff(L, theta(i));             % ∂L / ∂theta_i
        lagrange_eqs_theta(i) = simplify(dLdthetaDot_dt - dLdtheta); % Lagrange dla theta_i
    end

    % Równania dla xDot
    dLdxDot = diff(L, xDot);        % ∂L / ∂xDot
    dLdxDot_dt = diff(dLdxDot, t); % d/dt (∂L / ∂xDot)
    lagrange_eqs_xDot = simplify(dLdxDot_dt);

    % Równania dla yDot
    dLdyDot = diff(L, yDot);        % ∂L / ∂yDot
    dLdyDot_dt = diff(dLdyDot, t); % d/dt (∂L / ∂yDot)
    lagrange_eqs_yDot = simplify(dLdyDot_dt);

    % Zbiór wszystkich równań
    eq.theta = lagrange_eqs_theta;
    eq.xDot = lagrange_eqs_xDot;
    eq.yDot = lagrange_eqs_yDot;
end
