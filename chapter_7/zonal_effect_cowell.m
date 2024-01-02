function J2a = zonal_effect_cowell(R_sc3,THETA)


% omega = -23.634292247698090*pi/180;%Argument of perigee (rad)
% i = 22.890173649912693*pi/180;%Inclination of Lunar orbit (rad)
% OMEGA = 3.474684607397430e+02*pi/180;%RAAN (rad)
% th_ini = 0.365379699861768;%initial rotation
% R_z_OMEGA = [cos(-OMEGA) sin(-OMEGA) 0;...
%     -sin(-OMEGA) cos(-OMEGA) 0;...
%     0 0 1];
% 
% 
G = 6.673e-20; %gravitational constant
M_e = 5.9742e24 ; %mass of earth (kg)
 Rr = 6378.1;
% 
% 
% R_x_i = [1 0 0; 0 cos(-i) sin(-i); 0 -sin(-i) cos(-i)];
% 
% R_z_Ib = [cos(-theta) sin(-theta) 0; -sin(-theta) cos(-theta) 0;0 0 1];%transformation matrix for rotation of reference frame
% R_z_omega = [cos(-omega) sin(-omega) 0;...
%     -sin(-omega) cos(-omega) 0;...
%     0 0 1];
% R_z_ini = [cos(-th_ini) sin(-th_ini) 0;...
%     -sin(-th_ini) cos(-th_ini) 0;...
%     0 0 1];

% R_e = [4688 0 0]';%position of Earth with respect to bary-centric rotating coordinate
% R_e_Ib = R_z_Ib*R_e;%position of Earth with respect to bary-centric inertial frame
% r_Ib = R_z_Ib*r;%Position of s/c with respect to bary-centric inertial frame
% R_sc_ec = r_Ib - R_e_Ib;%position of s/c with respect to moving Earth
% R_sc3 = R_z_OMEGA*R_x_i*R_z_omega*R_z_ini'*R_sc_ec;




    rsq = norm(R_sc3)^2;
    R_Z_efECI = [cos(THETA) sin(THETA) 0;...
      -sin(THETA) cos(THETA) 0;...
      0 0 1]; 
 
    R_sc3_ef = R_Z_efECI*R_sc3;
 
    x = R_sc3_ef(1);
    y = R_sc3_ef(2);
    z = R_sc3_ef(3);

    V00 = Rr/norm(R_sc3);
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

    C20 = -484.165368*10e-6;
    S20 = 0;

    x_ddot20 = G*M_e/Rr^2*(-C20*V31);
    y_ddot20 = G*M_e/Rr^2*(-C20*W31);
    z_ddot20 = G*M_e/Rr^2*3*(-C20*V30 - S20*W30);

    J2a = (R_Z_efECI'*[x_ddot20 y_ddot20 z_ddot20]');
    
    %J2b = R_z_Ib'*R_z_ini*R_z_omega'*R_x_i'*R_z_OMEGA'*J2a;