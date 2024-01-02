function x_dot = sat_dynamicsUKF(t,x)
global sigma_a sigma_v
G = 6.673e-11; %gravitational constant
M_e = 5.9742e24 ; %mass of earth (kg)
r = x(1:3);
v = x(4:6);
r_ddot = -G*M_e*r/norm(r)^3;% + sigma_a;% + J2a;
r_dot = v + sigma_v;
b_dot = 0;
x_dot = [r_dot;r_ddot;b_dot;zeros(7,1)]; 
% mu = 398600.4418;
% J2 = 0.00108263;
% R = 6378.137;
% J2term = (1 - J2*(R/norm(r))^2*(7.5*(r(3)/norm(r))^2) - 1.5);
% x_ddot = -mu*r(1)/(norm(r))^3*J2term;
% y_ddot = -mu*r(2)/(norm(r))^3*J2term;
% z_ddot = -mu*r(3)/(norm(r))^3*J2term;
%r_ddot = [x_ddot;y_ddot;z_ddot];