function correction = relativistic(t,eph)

GM = 3.986005e14;             % earth's universal gravitational
% parameter m^3/s^2
c = 299792458; %m/s

M0      =   eph(3);
roota   =   eph(4);
deltan  =   eph(5);
ecc     =   eph(6);
toe     =  eph(18);

A = roota*roota;
tk = gps_time_repair(t-toe);
n0 = sqrt(GM/A^3);
n = n0+deltan;
M = M0+n*tk;
M = rem(M+2*pi,2*pi);
E = M;
for i = 1:10
   E_old = E;
   E = M+ecc*sin(E);
   dE = rem(E-E_old,2*pi);
   if abs(dE) < 1.e-12
      break;
   end
end
E = rem(E+2*pi,2*pi);

correction = 2*sqrt(GM)/c^2*ecc*roota*sin(E);
end