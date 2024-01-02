function J = LV_Fjacobian(X)
global g T D dT dD me_dot R_LS pitch_ctl Pitch_ctl_alt
Re = norm(R_LS);
%%
delxdot_delX(1,1) = 0;
delxdot_delX(1,2) = - Re*X(3)*cos(X(4))/(Re + X(2))^2;
delxdot_delX(1,3) = Re*cos(X(4))/(Re + X(2));
delxdot_delX(1,4) = - Re*X(3)*sin(X(4))/(Re + X(2));
delxdot_delX(1,5) = 0;
delxdot_delX(1,6) = 0;
delxdot_delX(1,7) = 0;
delxdot_delX(1,8) = 0;
delxdot_delX(1,9) = 0;
%%
delhdot_delX(1,1) = 0;
delhdot_delX(1,2) = 0;
delhdot_delX(1,3) = sin(X(4));
delhdot_delX(1,4) = X(3)*cos(X(4));
delhdot_delX(1,5) = 0;
delhdot_delX(1,6) = 0;
delhdot_delX(1,7) = 0;
delhdot_delX(1,8) = 0;
delhdot_delX(1,9) = 0;
%%
delvdot_delX(1,1) = 0;
delvdot_delX(1,2) = 0;
delvdot_delX(1,3) = -2*D/X(3)/X(5);
delvdot_delX(1,4) = -g*cos(X(4));
delvdot_delX(1,5) = -(T-D)/X(5)^2;
delvdot_delX(1,6) = - D/X(6)/X(5);
delvdot_delX(1,7) = 0;
delvdot_delX(1,8) = 0;
delvdot_delX(1,9) = 0;
%%
%gamma_dot = -1/(X(3))*(g - X(3)^2/(Re + X(2)))*cos(X(4)) + pitch_ctl;
a = (g/X(3)^2 + 1/(Re + X(2)))/(-g/X(3)^2 + 1/(Re + X(2)));
delgammadot_delX(1,1) = 0;
delgammadot_delX(1,2) = - X(3)*cos(X(4))/(Re + X(2))^2;
delgammadot_delX(1,3) = g*cos(X(4))/X(3)^2 + cos(X(4))/(Re + X(2));
if X(2)> Pitch_ctl_alt
    delgammadot_delX(1,4) = 1/X(3)*(g - X(3)^2/(Re + X(2)))*sin(X(4));% - g*X(4)/X(3)*a*cos(X(4));
else
    delgammadot_delX(1,4) = 1/X(3)*(g - X(3)^2/(Re + X(2)))*sin(X(4));
end
delgammadot_delX(1,5) = 0;
delgammadot_delX(1,6) = 0;
delgammadot_delX(1,7) = 0;
delgammadot_delX(1,8) = 0;
delgammadot_delX(1,9) = 0;
%%
delmdot_delX = [0 0 0 0 0 0 0 0 0];
delCdot_delX = [0 0 0 0 0 0 0 0 0];
%%
deladot_delX(1,1) = 0;
deladot_delX(1,2) = g*X(3)*(cos(X(4)))^2/(Re + X(2));
deladot_delX(1,3) = (-g^2/X(3)^2 - g/(Re + X(2)))*(cos(X(4)))^2 - me_dot/X(5)^2*2*D/X(3) - 2*-(dD)/X(3)/X(5);    
deladot_delX(1,4) = -2*g/X(3)*(g - X(3)^2/(Re + X(2)))*cos(X(4))*sin(X(4));
deladot_delX(1,5) = me_dot*(D-T)/X(5)^3 - (dT - dD)/X(5)^2;
deladot_delX(1,6) = -me_dot/X(5)^2*D/X(6) - dD/X(6)/X(5);
deladot_delX(1,7) = 0;
deladot_delX(1,8) = 0;
deladot_delX(1,9) = 0;
%%
delbdot_delX = [0 0 0 0 0 0 0 0 1];
delbddot_delX = [0 0 0 0 0 0 0 0 0];
J = [delxdot_delX; delhdot_delX; delvdot_delX; delgammadot_delX; delmdot_delX; delCdot_delX; deladot_delX; delbdot_delX; delbddot_delX];


