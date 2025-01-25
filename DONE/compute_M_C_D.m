function [M, C, D] = compute_M_C_D(n, m, L, I, dphi, dtheta, dxy, q, q_dot)
    % Macierz masowa
    M = zeros(n + 2); % Rozmiar zależy od liczby członów (n + 2 dla xg, yg)
    for i = 1:n
        M(i, i) = I + m * (L^2 / 12); % Moment bezwładności członów
    end
    M(n+1, n+1) = m; % Masa translacyjna dla xg
    M(n+2, n+2) = m; % Masa translacyjna dla yg

    % Macierz sił odśrodkowych
    C = zeros(n + 2,n);
    for i = 1:n
        for j = 1:n
            % Siły odśrodkowe dla segmentów
            if i >= j % tylko segmenty wpływające na siebie nawzajem
                C(i, j) = -m * (L / 2) * sin(q(i) - q(j)) * q_dot(j);
            end
        end
    end
    
    % Wypełnienie wpływu segmentów na głowę (xg, yg)
    for j = 1:n
        % xg: wpływ kąta na współrzędną x
        C(n + 1, j) = -m * L * cos(q(j)) * q_dot(j); 
        
        % yg: wpływ kąta na współrzędną y
        C(n + 2, j) = -m * L * sin(q(j)) * q_dot(j);
    end
    
    D = diag([repmat(dphi + dtheta*q_dot(j), 1, n), dxy, dxy]); % Tarcie obrotowe i translacyjne

    % for j=1:n
    %     % Macierz tarcia
    %     D = diag([repmat(dphi + dtheta*q_dot(j), 1, n), dxy, dxy]); % Tarcie obrotowe i translacyjne
    % end 
   
end
