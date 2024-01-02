function [R_ECEF, V_ECEF] = Co_ord_change(X)
global phi lambda Az R_LS
RHO = DrngHgt2rec([X(1);X(2)]);
T_RHA = RHA_Trans(Az);
T_ECEF = NED2ECEF_Trans(phi,lambda);
R_ECEF = R_LS' + T_ECEF*T_RHA*RHO;
T_loc = [cos(X(4));sin(X(4));0];
T_rot = rotation(X(1));
%omega = -X(3)*cos(X(4))/(norm(R_LS) + X(2));
%W = [0;0;omega];
%l_vec = [0;norm(R_LS)+X(2);0];
%V_ECEF = T_ECEF*T_RHA*T_rot*(T_loc*X(3)+ cross(W,l_vec));
V_ECEF = T_ECEF*T_RHA*T_rot*T_loc*X(3);