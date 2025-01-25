function [p, cm] = update_q(n, L, q)
    % Aktualizacja przegubów i środków mas na podstawie nowych współrzędnych uogólnionych
    p = zeros(n+1, 2);  % Przeguby
    cm = zeros(n, 2);   % Środki mas

    % Pozycja głowy
    p(1,1) = q(n+1); % xg
    p(1,2) = q(n+2); % yg

    % Aktualizacja pozycji przegubów i środków mas
    for i = 1:n
        % Przeguby
        if i > 1
            p(i,1) = p(i-1,1) + cos(q(i-1)) * L;
            p(i,2) = p(i-1,2) + sin(q(i-1)) * L;
        end

        % Środek masy
        cm(i,1) = p(i,1) + cos(q(i)) * L / 2;
        cm(i,2) = p(i,2) + sin(q(i)) * L / 2;

        % Końcowy przegub
        if i == n
            p(i+1,1) = cm(i,1) + cos(q(i)) * L / 2;
            p(i+1,2) = cm(i,2) + sin(q(i)) * L / 2;
        end
    end
end
