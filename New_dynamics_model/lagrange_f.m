function L = lagrange_f(n)

syms L m Ic real   % Długość, masa, moment bezwładności (stałe)
syms x(t) y(t)                       
syms theta(t) [1 n]                

xDot = diff(x, t);                  
yDot = diff(y, t);                   
thetaDot = diff(theta, t);           


T_x = 0;
for i = 1:n
    if i > 1
        inner_sum_x = 0;
        for j = 1:i-1
            inner_sum_x = inner_sum_x + sin(theta(j)) * thetaDot(j);
        end
    else
        inner_sum_x = 0;
    end
    T_x = T_x + 0.5 * m * (xDot - 2 * L * inner_sum_x - L * sin(theta(i)) * thetaDot(i))^2;
end

% 
% T_y = 0;
% for i = 1:n
%     if i > 1
%         inner_sum_y = 0;
%         for j = 1:i-1
%             inner_sum_y = inner_sum_y + cos(theta(j)) * thetaDot(j);
%         end
%     else
%         inner_sum_y = 0;
%     end
%     T_y = T_y + 0.5 * m * (yDot + 2 * L * inner_sum_y + L * cos(theta(i)) * thetaDot(i))^2;
% end
% 
% 
% T_theta = 0; 
% for i = 1:n
%     inner_sum_theta = 0; 
%     for j = 1:i
%         inner_sum_theta = inner_sum_theta + thetaDot(j)^2;
%     end
%     T_theta = T_theta + 0.5 * Ic * inner_sum_theta;
% end

% % Całkowita energia układu (brak V - e. potencjalnej)
% L = simplify(T_x + T_y + T_theta);
% 
% disp('Funkcja Lagrangea:');
% disp(L);

disp(simplify(T_x));

end
