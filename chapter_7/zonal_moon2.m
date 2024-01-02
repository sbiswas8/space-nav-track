function J2m = zonal_moon2(r_sc_m)
    omega = -23.634292247698090*pi/180;%Argument of perigee (rad)
i = 22.890173649912693*pi/180;%Inclination of Lunar orbit (rad)
OMEGA = 3.474684607397430e+02*pi/180;%RAAN (rad)
th_ini = 0.365379699861768;%initial rotation
R_z_OMEGA = [cos(-OMEGA) sin(-OMEGA) 0;...
    -sin(-OMEGA) cos(-OMEGA) 0;...
    0 0 1];


% G = 6.673e-20; %gravitational constant
% M_e = 5.9742e24 ; %mass of earth (kg)
% Rr = 6378.1;


R_x_i = [1 0 0; 0 cos(-i) sin(-i); 0 -sin(-i) cos(-i)];

%R_z_Ib = [cos(-theta) sin(-theta) 0; -sin(-theta) cos(-theta) 0;0 0 1];%transformation matrix for rotation of reference frame
R_z_omega = [cos(-omega) sin(-omega) 0;...
    -sin(-omega) cos(-omega) 0;...
    0 0 1];
R_z_ini = [cos(-th_ini) sin(-th_ini) 0;...
    -sin(-th_ini) cos(-th_ini) 0;...
    0 0 1];

axtilt = - 6.68*pi/180;

Ry =  [cos(axtilt) 0 -sin(axtilt);...
      0 1 0;...
      sin(axtilt) 0 cos(axtilt)];
  
r = Ry*R_z_omega'*R_x_i'*R_z_OMEGA'*r_sc_m;
rsq = norm(r)^2;
x = r(1);
y = r(2);
z = r(3);
G = 6.673e-20; %gravitational constant
M_e = 7.347*10e22; %mass of earth (kg)
Rr = 1737.10;

V00 = Rr/norm(r_sc_m);
    W00 = 0;
    
    V11 = x*Rr/rsq*V00 - y*Rr/rsq*W00;
    W11 = x*Rr/rsq*W00 + y*Rr/rsq*V00;

    V21 = 3*z*Rr/rsq*V11 - 2*Rr^2/rsq*V00;
    W21 = 3*z*Rr/rsq*W11 - 2*Rr^2/rsq*W00;

    V31 = 5/2*z*Rr/rsq*V21 - 3/2*Rr^2/rsq*V11;
    W31 = 5/2*z*Rr/rsq*W21 - 3/2*Rr^2/rsq*W11;

    V10 = z*Rr/rsq*V00;
    W10 = z*Rr/rsq*W00;

    V20 = 3/2*z*Rr/rsq*V10 - 0.5*Rr^2/rsq*V00;
    W20 = 3/2*z*Rr/rsq*W10 - 0.5*Rr^2/rsq*W00;

    V30 = 5/3*z*Rr/rsq*V20 - 2/3*Rr^2/rsq*V10;
    W30 = 5/3*z*Rr/rsq*W20 - 2/3*Rr^2/rsq*W10;

    C20 = 2.033542482111609*10e-4;
    S20 = 0;

    x_ddot20 = G*M_e/Rr^2*(-C20*V31);
    y_ddot20 = G*M_e/Rr^2*(-C20*W31);
    z_ddot20 = G*M_e/Rr^2*3*(-C20*V30 - S20*W30);
   
    J2 = (Ry'*[x_ddot20 y_ddot20 z_ddot20]');
    
    J2m = R_z_OMEGA*R_x_i*R_z_omega*J2;