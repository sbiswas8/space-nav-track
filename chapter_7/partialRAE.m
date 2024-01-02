function [Hx, Z_est] = partialRAE(X_priori,time,phi,lambda)
t = time;
R = [X_priori(1) X_priori(2) X_priori(3)]';
% V = [X_priori(4) X_priori(5) X_priori(6)]';
% omega_earth = [0; 0; 7.2921158553*10^-5];
d = 55804 - 51544.5 + 20;
THETA = (280.4606+360.9856473*(d + t/(3600*24)))*pi/180;

R_Z_efECI = [cos(THETA) sin(THETA) 0;...
             -sin(THETA) cos(THETA) 0;...
             0 0 1]; 
E_loc = [-sin(lambda) -sin(phi)*cos(lambda) cos(phi)*cos(lambda);...
         cos(lambda) -sin(phi)*sin(lambda) cos(phi)*sin(lambda);...
         0 cos(phi) sin(phi)]'; 

f = 1.0/298.257223563;                                                    %Flattening; WGS-84
e2 = f*(2.0-f);
N = 6378.137 / sqrt(1.0-e2*(sin(phi))^2);

R_gnd = [N*cos(phi)*cos(lambda);N*cos(phi)*sin(lambda);(1-e2)*N*sin(phi)]; %Ground station at ef frame

R_sc3_ef = R_Z_efECI*R;
S_ef = R_sc3_ef - R_gnd;

S = E_loc*S_ef;
s = norm(S);

A = atan2(S(1,1),S(2,1));
E = atan2(S(3,1),sqrt(S(1,1)^2+S(2,1)^2));
Z_est = [s A E];
clear E;
E = E_loc;
U = R_Z_efECI;

s = norm(S);

sE = S(1);
sN = S(2);
sZ = S(3);

del_A_del_R = [sN/(sE^2 + sN^2) -sE/(sE^2 + sN^2) 0]*E*U;
del_E_del_R = [-sE*sZ/(s^2*sqrt(sE^2 + sN^2)) -sN*sZ/(s^2*sqrt(sE^2 + sN^2))...
               sqrt(sE^2 + sN^2)/s^2]*E*U;
           



del_range_del_R = S'/s*E*U;

Hx = [del_range_del_R 0 0 0;
         del_A_del_R 0 0 0;
         del_E_del_R 0 0 0];
  

end