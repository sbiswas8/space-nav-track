function X_dot = rentrydyn(t,X)
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
X_dot(1,1) = X(3)*sin(X(4)) + w1*randn;
X_dot(2,1) = X(3)*cos(X(4)) + w2*randn;
X_dot(3,1) = - g*sin(X(4)) - D/m + w3*randn;
X_dot(4,1) = - g/X(3)*cos(X(4)) + w4*randn;
X_dot(5,1) = 0 + w5*randn;