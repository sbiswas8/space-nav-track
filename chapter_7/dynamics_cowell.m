function dX = dynamics_cowell(t,X,THETA,t_TH)
r = X(1:3);
r_dot = X(4:6);
R_m = X(7:9);
R_v = X(10:12);

Theta = interp1(t_TH,THETA,t);
J2a = zonal_effect_cowell(r,Theta);
J2m = zonal_moon2(R_m - r);
rddots = solar_prtb2(r);
rddotRP = radiation2(r);

dXsc = zeros(6,1);
dXm = zeros(6,1);

G = 6.673e-20; %gravitational constant
M_e = 5.9742e24 ; %mass of earth (kg)
M_m = M_e/81; %mass of moon (kg)

r_ddot1 = - G*M_e*r/norm(r)^3 + G*M_m*((R_m - r)/norm(R_m - r)^3 - R_m/norm(R_m)^3);
r_ddotm = - G*M_e*R_m/norm(R_m)^3;

r_ddot = r_ddot1 - J2a + J2m + rddots + rddotRP;

dXsc(1:3) = r_dot;
dXsc(4:6) = r_ddot;
dXm(1:3) = R_v;
dXm(4:6) = r_ddotm;

dX = [dXsc;dXm];
