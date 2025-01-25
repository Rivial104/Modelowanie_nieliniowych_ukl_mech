function L = lagrange_f_works(n)

    syms L m Ic real            
    syms x(t)
    syms y(t)
    syms theta(t) [1 n]          

    xDot = diff(x, t);
    yDot = diff(y, t);

    thetaDot = sym('thetaDot', [1 n]);  


    T_x = 0;
    for i = 1:n
        thetaDot(1,i) = diff(theta(1,i), t); 
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


    T_y = 0;
    for i = 1:n
        if i > 1
            inner_sum_y = 0;
            for j = 1:i-1
                inner_sum_y = inner_sum_y + cos(theta(j)) * thetaDot(j);
            end
        else
            inner_sum_y = 0;
        end
        T_y = T_y + 0.5 * m * (yDot + 2 * L * inner_sum_y + L * cos(theta(i)) * thetaDot(i))^2;
    end

    T_theta = 0;
    for i = 1:n
        inner_sum_theta = 0;
        for j = 1:i
            inner_sum_theta = inner_sum_theta + thetaDot(j)^2;
        end
        T_theta = T_theta + 0.5 * Ic * inner_sum_theta;
    end


    L = simplify(T_x + T_y + T_theta);
    disp('Funkcja Lagrangea:');
    disp(L);

end
