function Xdot = lvdyn_true(t,X)
global g T pitch_ctl me_dot dT D dD R_LS
Re = norm(R_LS);
Xdot(1,1) = Re/(Re + X(2))*X(3)*cos(X(4));
Xdot(2,1) = X(3)*sin(X(4));
Xdot(3,1) =(T-D)/X(5) - g*sin(X(4)) + 1e-4.*randn;
Xdot(4,1) = -1/(X(3))*(g - X(3)^2/(Re + X(2)))*cos(X(4)) + pitch_ctl;% + 1e-8.*randn;
Xdot(5,1) = -me_dot;
Xdot(6,1) = 1e-3.*randn;
Xdot(7,1) = Xdot(5)*(D-T)/(X(5))^2 + (dT-dD)/X(5) - g*Xdot(4)*cos(X(4)) + 1e-3.*randn;