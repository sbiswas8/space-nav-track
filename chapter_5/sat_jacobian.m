function del_F = sat_jacobian(X)
r = X(1:3);
G = 6.673e-11; %gravitational constant
M_e = 5.9742e24 ; %mass of earth (kg)
Partial_r_ddot = - G*M_e*(eye(3)/(norm(r))^3 - 3*(r*r')/(norm(r))^5);
del_F = [[zeros(3) eye(3); Partial_r_ddot zeros(3)] zeros(6,1); [zeros(1,6) 0]];