function [A, B, H] = compute_A_B_H(n,q,L)

A = zeros(n,n);
B = zeros(n,2);
H = zeros(n,2);

for i=1:n
    for j=1:n
       % Wypełnianie macierzy A
       if (i==j)
            A(i,j) = -L/2;
       elseif i > j
            A(i,j) = -L*cos(q(i)-q(j));
       end 
    end 
    % Wypełnianie macierzy B
    B(i,1) = -sin(q(i));
    B(i,2) = cos(q(i));
end 

H = -(A\B);