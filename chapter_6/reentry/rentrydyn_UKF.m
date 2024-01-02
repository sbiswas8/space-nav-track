function X_dot = rentrydyn_UKF(t,X)
global m
g = 9.81;
H = 7.1628*1000; % height scale in m
rho = 1.2366; % air density in kg/m^3
A = pi*4^2/4; %area of the vehicle
D = 0.5*X(5)*A*rho*exp(-X(1)/H)*X(3)^2;
%% Process noise standard deviation
w1 = 0;
w2 = 0;
w3 = 0;
w4 = 0;
w5 = 0;
%%
X_dot(1,1) = X(3)*sin(X(4)) + X(6);
X_dot(2,1) = X(3)*cos(X(4)) + X(7);
X_dot(3,1) = - g*sin(X(4)) - D/m + X(8);
X_dot(4,1) = - g/X(3)*cos(X(4)) + X(9);
X_dot(5,1) = 0 + X(10);
X_dot(6,1) = 0;
X_dot(7,1) = 0;
X_dot(8,1) = 0;
X_dot(9,1) = 0;
X_dot(10,1) = 0;