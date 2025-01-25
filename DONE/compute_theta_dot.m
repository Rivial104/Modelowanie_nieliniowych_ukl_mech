function theta_dot = compute_theta_dot(H, B, r_dot)
    % Funkcja obliczająca prędkości kątowe (theta_dot)
    theta_dot = H \ (B * r_dot); % Rozwiązanie równań więzów
end
