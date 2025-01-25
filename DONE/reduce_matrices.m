function [M_tilde, C_tilde, D_tilde] = reduce_matrices(H, M, C, D)
    n = size(H, 1);
    I2 = eye(2);
    % H_extended = [H; eye(2)];

    P1 = [H' I2]; % Rzutowanie do przestrzeni r
    P2 = [H; I2];
    M_tilde = P1 * M * P2;

    a1 = M*[H; zeros(2,2)];
    a2 = P1*a1;
    b1 = C*H;
    b2=P1*b1;

    C_tilde = a2+b2;
    % C_tilde = P1 * (M * [H; zeros(2,2)] + P1*C * H);
    D_tilde = P1 * D * P2;
end
