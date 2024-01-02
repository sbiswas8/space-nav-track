function [Hx, Z_est] = partialRR(X_priori,time,phi,lambda)
t = time;
R = [X_priori(1) X_priori(2) X_priori(3)]';
V = [X_priori(4) X_priori(5) X_priori(6)]';
omega_earth = [0; 0; 7.2921158553*10^-5];
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
v_ef = R_Z_efECI*V - cross(omega_earth,R_Z_efECI*R);
S_dot = E_loc*v_ef;
s = norm(S);
Z_est = dot(S_dot,S/s);

E = E_loc;
U = R_Z_efECI;

s = norm(S);
s_dot = norm(S_dot);

del_rr_del_R = (s*S_dot' - s_dot*S')/s^2;
           
del_rr_del_v = S'/s*E*U;

Hx = [del_rr_del_R del_rr_del_v];
end
