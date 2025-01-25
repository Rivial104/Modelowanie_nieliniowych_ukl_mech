function y_next = rk4_step(t, y, dt, f)
    % f: funkcja zwracająca pochodną dy/dt
    k1 = f(t, y);
    k2 = f(t + dt/2, y + dt/2 * k1);
    k3 = f(t + dt/2, y + dt/2 * k2);
    k4 = f(t + dt, y + dt * k3);
    y_next = y + dt/6 * (k1 + 2*k2 + 2*k3 + k4);
end
