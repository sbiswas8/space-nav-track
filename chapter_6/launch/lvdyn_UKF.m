function Xdot = lvdyn_UKF(t,X)
global g T pitch_ctl me_dot dT D dD R_LS
Re = norm(R_LS);
Xdot(1,1) = Re/(Re + X(2))*X(3)*cos(X(4));% + X(10);
Xdot(2,1) = X(3)*sin(X(4));% + X(11);
Xdot(3,1) =(T-D)/X(5) - g*sin(X(4));% + X(12);
Xdot(4,1) = -1/(X(3))*(g - X(3)^2/(Re + X(2)))*cos(X(4)) + pitch_ctl;% + X(13);
Xdot(5,1) = -me_dot;% + X(14);
Xdot(6,1) = 0;% + X(15);
Xdot(7,1) = Xdot(5)*(D-T)/(X(5))^2 + (dT-dD)/X(5) - g*Xdot(4)*cos(X(4));% + X(16);
Xdot(8,1) = X(9);% + X(17);
Xdot(9,1) =0;% X(18);
Xdot(10:18,1) = zeros(9,1);