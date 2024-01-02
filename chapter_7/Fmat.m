function DEL_F = Fmat(R_moon,X,t)
d = 55804 - 51544.5 + 20;
THETA = (280.4606+360.9856473*(d + t/(3600*24)))*pi/180;

U = [cos(THETA) sin(THETA) 0;...
             -sin(THETA) cos(THETA) 0;...
             0 0 1]; 
         
R0 = [X(1) X(2) X(3)]';
R1 = U*R0;
G = 6.673e-20;
M_e = 5.9742e24;
M_m = 5.9742e24/81;
Re = 6378.1;
C20 = -484.165e-6;
partial_a_r_earth = -G*M_e*(1/(norm(R0))^3*eye(3) - 3*(R0*R0')/(norm(R0))^5);

partial_a_r_moon = -G*M_m*(1/(norm(R0 - R_moon'))^3*eye(3)...
    - 3*((R0 - R_moon')*(R0 - R_moon')')/(norm(R0 - R_moon'))^5);
partial_a_r = partial_a_r_earth + partial_a_r_moon;

V0 = Re/norm(R0);
W0 = 0;

[V10 W10] = VW(1,0,R1,V0,W0,0,0);
[V20 W20] = VW(2,0,R1,V10,W10,V0,W0);
[V30 W30] = VW(3,0,R1,V20,W20,V10,W10);
[V40 W40] = VW(4,0,R1,V30,W30,V20,W20);

[V11 W11] = VWm(1,R1,V0,W0);
[V21 W21] = VW(2,1,R1,V11,W11,0,0);
[V31 W31] = VW(3,1,R1,V21,W21,V11,W11);
[V41 W41] = VW(4,1,R1,V31,W31,V21,W21);

[V22 W22] = VWm(2,R1,V11,W11);
[V32 W32] = VW(3,2,R1,V22,W22,0,0);
[V42 W42] = VW(4,2,R1,V32,W32,V22,W22);

delXX = G*M_e/Re^3*1/2*(C20*V42 - factorial(4)/2*C20*V40);
delXY = G*M_e/Re^3*1/2*C20*W42;
delXZ = G*M_e/Re^3*3*C20*V41;
delYZ = G*M_e/Re^3*3*C20*W41;
delZZ = G*M_e/Re^3*factorial(4)/2*C20*V40 + 0*W40;

partialJ2 = U'*[delXX delXY delXZ;...
             0 0 delYZ;...
             0 0 delZZ]*U;
%% LUNAR J2

axtilt = - 6.68*pi/180;

Ry =  [cos(axtilt) 0 -sin(axtilt);...
      0 1 0;...
      sin(axtilt) 0 cos(axtilt)];
  
  
omega = -23.634292247698090*pi/180;%Argument of perigee (rad)
i = 22.890173649912693*pi/180;%Inclination of Lunar orbit (rad)
OMEGA = 3.474684607397430e+02*pi/180;%RAAN (rad)
th_ini = 0.365379699861768;%initial rotation
R_z_OMEGA = [cos(-OMEGA) sin(-OMEGA) 0;...
    -sin(-OMEGA) cos(-OMEGA) 0;...
    0 0 1];

R_x_i = [1 0 0; 0 cos(-i) sin(-i); 0 -sin(-i) cos(-i)];

%R_z_Ib = [cos(-theta) sin(-theta) 0; -sin(-theta) cos(-theta) 0;0 0 1];%transformation matrix for rotation of reference frame
R_z_omega = [cos(-omega) sin(-omega) 0;...
    -sin(-omega) cos(-omega) 0;...
    0 0 1];
R_z_ini = [cos(-th_ini) sin(-th_ini) 0;...
    -sin(-th_ini) cos(-th_ini) 0;...
    0 0 1];

R = R_z_omega'*R_x_i'*R_z_OMEGA'*(R0 - R_moon');

%r = R_z_Ib'*R;
Rm = Ry*R;

C20 = 2.033542482111609*10e-4;
Rr = 1737.10;
V0 = Rr/norm(Rm);
W0 = 0;

[V10 W10] = VW(1,0,Rm,V0,W0,0,0);
[V20 W20] = VW(2,0,Rm,V10,W10,V0,W0);
[V30 W30] = VW(3,0,Rm,V20,W20,V10,W10);
[V40 W40] = VW(4,0,Rm,V30,W30,V20,W20);

[V11 W11] = VWm(1,Rm,V0,W0);
[V21 W21] = VW(2,1,Rm,V11,W11,0,0);
[V31 W31] = VW(3,1,Rm,V21,W21,V11,W11);
[V41 W41] = VW(4,1,Rm,V31,W31,V21,W21);

[V22 W22] = VWm(2,Rm,V11,W11);
[V32 W32] = VW(3,2,Rm,V22,W22,0,0);
[V42 W42] = VW(4,2,Rm,V32,W32,V22,W22);
Rr = 1737.10;
delXX = G*M_e/Rr^3*1/2*(C20*V42 - factorial(4)/2*C20*V40);
delXY = G*M_e/Rr^3*1/2*C20*W42;
delXZ = G*M_e/Rr^3*3*C20*V41;
delYZ = G*M_e/Rr^3*3*C20*W41;
delZZ = G*M_e/Rr^3*factorial(4)/2*C20*V40 + 0*W40;

partialJ2m = R_z_OMEGA*R_x_i*R_z_omega*Ry'*[delXX delXY delXZ;...
             0 0 delYZ;...
             0 0 delZZ]*Ry*R_z_omega'*R_x_i'*R_z_OMEGA';

         
Ms = 1.9891e30;%Mass of the sun
S = [-150080990.696144;6674541.15635724;3443575.71073491];

partial_a_r_S = -G*Ms*(1/(norm(R0 - S))^3*eye(3)...
    - 3*((R0 - S)*(R0 - S)')/(norm(R0 - S))^5);

%%
DEL_F = [zeros(3) eye(3);
         partial_a_r-partialJ2+partialJ2m+partial_a_r_S zeros(3)];
end