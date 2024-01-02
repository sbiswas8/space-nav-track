function rddots = solar_prtb2(R_sc3)
Ms = 1.9891e30;%Mass of the sun
G = 6.673e-20; %gravitational constant


S = [-150080990.696144;6674541.15635724;3443575.71073491];

rddots = G*Ms*((S - R_sc3)/norm(S - R_sc3)^3 - S/norm(S)^3);




% omega = -23.634292247698090*pi/180;%Argument of perigee (rad)
% i = 22.890173649912693*pi/180;%Inclination of Lunar orbit (rad)
% OMEGA = 3.474684607397430e+02*pi/180;%RAAN (rad)
% th_ini = 0.365379699861768;%initial rotation
% R_z_OMEGA = [cos(-OMEGA) sin(-OMEGA) 0;...
%     -sin(-OMEGA) cos(-OMEGA) 0;...
%     0 0 1];
% R_x_i = [1 0 0; 0 cos(-i) sin(-i); 0 -sin(-i) cos(-i)];
% 
% R_z_Ib = [cos(-theta) sin(-theta) 0; -sin(-theta) cos(-theta) 0;0 0 1];%transformation matrix for rotation of reference frame
% R_z_omega = [cos(-omega) sin(-omega) 0;...
%     -sin(-omega) cos(-omega) 0;...
%     0 0 1];
% R_z_ini = [cos(-th_ini) sin(-th_ini) 0;...
%     -sin(-th_ini) cos(-th_ini) 0;...
%     0 0 1];

%rddotsb = R_z_Ib'*R_z_ini*R_z_omega'*R_x_i'*R_z_OMEGA'*rddots;