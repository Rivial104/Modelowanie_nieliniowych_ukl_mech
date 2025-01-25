function H = compute_H(n, L, q)
    H = zeros(n, 2);
    for i = 1:n
        H(i, 1) = -L * cos(q(i));
        H(i, 2) = -L * sin(q(i));
    end
    H = -inv(H); % Odwrócenie macierzy
end
