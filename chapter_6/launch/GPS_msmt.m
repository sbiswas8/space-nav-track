function Z = GPS_msmt(X)
global GPSPVT phi lambda Az R_LS NS
Z = nan(1);
%NS = length(GPSPVT.SP);
RHO = DrngHgt2rec([X(1);X(2)]);
T_RHA = RHA_Trans(Az);
%T_VRHA = VRHA_Trans(X(4),Az);
T_ECEF = NED2ECEF_Trans(phi,lambda);
R_ECEF = R_LS' + T_ECEF*T_RHA*RHO;
T_loc = [cos(X(4));sin(X(4));0];
T_rot = rotation(X(1));
omega = -X(3)*cos(X(4))/(norm(R_LS) + X(2));
W = [0;0;omega];
l_vec = [0;norm(R_LS)+X(2);0];
V_ECEF = T_ECEF*T_RHA*T_rot*(T_loc*X(3)+ cross(W,l_vec));
%V_ECEF = T_ECEF*T_RHA*T_rot*T_loc*X(3);
for i = 1:NS
        SP_ECEF = GPSPVT.SP(i,:)';
        SPV_ECEF = GPSPVT.SPV(i,:)';
        Z(i,1) = norm(SP_ECEF - R_ECEF) + X(8);
        V_rel = SPV_ECEF - V_ECEF;
        Z(i+ NS,1) = (SP_ECEF - R_ECEF)'*V_rel/norm(SP_ECEF - R_ECEF) + X(9);
end