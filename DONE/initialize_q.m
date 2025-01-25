function [q, p, cm] = initialize_q(n, L, head_init, theta)

    % Inicjalizuje współrzędne uogólnione dla n członów
    q = zeros(n+2,1);  % [theta1, theta2, ..., thetan, xg, yg]

    % Inicjalizacja wektora z punktami przegubowymi członów
    p = zeros(n+1,2);

    cm = zeros(n,2);

    % Wczytanie położenia głowy robota
    q(n+1) = head_init(1);
    q(n+2) = head_init(2);
    p(1,1) = q(n+1);
    p(1,2) = q(n+2);

    for i=1:n
        q(i) = theta(i);%*(-1)^i; % Wyginanie każdego kolejnego członu w inną stronę

        
        % Wyznaczenie współrzędnych n przegubów dla n członów
        if i>1
            p(i,1) = p(i-1,1) - cos(q(i-1))*L;
            p(i,2) = p(i-1,2) - sin(q(i-1))*L;
        end 

        % Wyznaczenie współrzędnych CM n członów
        cm(i,1) = p(i,1) - cos(q(i))*L/2;
        cm(i,2) = p(i,2) - sin(q(i))*L/2;
        
        % Wyznaczenie współrzędnych przegubu n+1
        if i == n
            p(i+1,1) = cm(i,1) - cos(q(i))*L/2;
            p(i+1,2) = cm(i,2) - sin(q(i))*L/2;
        end 

    end
end
