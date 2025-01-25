function handles = draw_system(n, cm, p, t, scale, handles)
    % Funkcja rysująca układ i umożliwiająca jego aktualizację
    if isempty(handles) % Inicjalizacja wykresu, jeśli to pierwszy krok
        figure;
        hold on;
        grid on

        % Rysowanie prętów między punktami przegubowymi
        for i = 1:n
            handles.rods(i) = plot([p(i,1), p(i+1,1)], [p(i,2), p(i+1,2)], ...
                                   'b-', 'LineWidth', 2); % Pręty
        end

        % Rysowanie środka masy
        for i = 1:n
            handles.centers(i) = plot(cm(i,1), cm(i,2), 'ro', 'MarkerFaceColor', 'r'); % Koła
        end

        % Formatowanie wykresu
        grid on;
        title('Symulacja ruchu robota-węża');
        xlabel('X [m]');
        ylabel('Y [m]');
        scale = 2;
        xlim([p(1,1) - scale, p(1,1) + scale]);
        ylim([p(1,2) - scale, p(1,2) + scale]);


        % % Dodanie tekstu w prawym dolnym rogu
        % handles.info_text = text(1.5, -1.5, '', 'FontSize', 12, ...
        %                          'HorizontalAlignment', 'right', ...
        %                          'VerticalAlignment', 'bottom', ...
        %                          'EdgeColor', 'k', 'BackgroundColor', 'w');

        hold off;
    else
        % Aktualizacja istniejących obiektów na wykresie
        for i = 1:n
            % Aktualizacja prętów
            set(handles.rods(i), 'XData', [p(i,1), p(i+1,1)], ...
                                 'YData', [p(i,2), p(i+1,2)]);

            % Aktualizacja środka masy
            set(handles.centers(i), 'XData', cm(i,1), 'YData', cm(i,2));
        end

        % Dynamiczne przeskalowanie osi względem głowy
        xlim([p(1,1) - scale, p(1,1) + scale]);
        ylim([p(1,2) - scale, p(1,2) + scale]);

        % Aktualizacja tekstu informacyjnego
        % info_str = sprintf('Czas symulacji: %.2f s\nLiczba członów: %d', t, n);
        % set(handles.info_text, 'String', info_str);
        drawnow; % Aktualizacja wykresu
    end
end
