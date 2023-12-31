function H = GPS_Mjacobian(X)
global phi lambda Az GPSPVT R_LS NS
H = nan(1,length(X));
%NS = length(GPSPVT.SP);
RHO = DrngHgt2rec([X(1);X(2)]);
Mrec = JDrngHgt2rec([X(1);X(2)]);
T_RHA = RHA_Trans(Az);
%T_VRHA = VRHA_Trans(X(4),Az);
T_loc = [cos(X(4));sin(X(4));0];
T_ECEF = NED2ECEF_Trans(phi,lambda);
R_ECEF = R_LS' + T_ECEF*T_RHA*RHO;
T_rot = rotation(X(1));
omega = -X(3)*cos(X(4))/(norm(R_LS) + X(2));
W = [0;0;omega];
l_vec = [0;norm(R_LS)+X(2);0];
V_ECEF = T_ECEF*T_RHA*T_rot*(T_loc*X(3)+ cross(W,l_vec));
%V_ECEF = T_ECEF*T_RHA*T_rot*T_loc*X(3);
for i = 1:NS
        SP_ECEF = GPSPVT.SP(i,:)';
        SPV_ECEF = GPSPVT.SPV(i,:)';
        C1 = 0.5*(norm(SP_ECEF - R_ECEF))^-1;
        RH_E = [C1*-2*(SP_ECEF(1) - R_ECEF(1)) C1*-2*(SP_ECEF(2) - R_ECEF(2)) C1*-2*(SP_ECEF(3) - R_ECEF(3))];
        r = norm(SP_ECEF - R_ECEF);
        R_rel = SP_ECEF - R_ECEF;
        V_rel = SPV_ECEF - V_ECEF;
        VRH_R = (r^-3*[1 1 1]*(R_rel'*V_rel) - r^-1*V_rel');
        VRH_E = -r^-1*R_rel';
        domega_dgamma = [0;0;X(3)*sin(X(4))/(norm(R_LS) + X(2))];
        delV_del_gamma = T_ECEF*T_RHA*T_rot*([-sin(X(4));cos(X(4));0]*X(3) + cross(domega_dgamma,l_vec));
        %delV_del_gamma = T_ECEF*T_RHA*T_rot*[-sin(X(4));cos(X(4));0]*X(3);
        H(i,:) = [RH_E*T_ECEF*T_RHA*Mrec 0 0 0 0 0 1 0];
        H(i+NS,:) = [VRH_R*T_ECEF*T_RHA*Mrec VRH_E*T_ECEF*T_RHA*T_rot*T_loc VRH_E*delV_del_gamma 0 0 0 0 1];
end