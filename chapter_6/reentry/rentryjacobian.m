function J = rentryjacobian(X)
%%
global m
g = 9.81;
H = 7.1628*1000; % height scale in m
rho = 1.2366; % air density in kg/m^3
A = pi*4^2/4; %area of the vehicle
%%
h = X(1);
d = X(2);
v = X(3);
l = X(4);
C = X(5);
%%
del_hdot_delX = [0 0 sin(l) v*cos(l) 0];
del_ddot_delX = [0 0 cos(l) -v*sin(l) 0];
del_vdot_delX = [1/(2*H*m)*C*A*rho*exp(-h/H)*v^2 0 -C/m*A*rho*exp(-h/H)*v -g*cos(l) -1/(2*m)*A*rho*exp(-h/H)*v^2];
del_ldot_delX = [0 0 -g/v^2*cos(l) -g/v*sin(l) 0];
del_Cdot_delX = [0 0 0 0 0];

J = [del_hdot_delX; del_ddot_delX; del_vdot_delX; del_ldot_delX; del_Cdot_delX];