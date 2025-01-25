function r_ddot = solve_motion(M_tilde, C_tilde, D_tilde, H, E, tau, r_dot)
r_ddot = M_tilde \ (H' * E * tau - (C_tilde + D_tilde) * r_dot);
end
