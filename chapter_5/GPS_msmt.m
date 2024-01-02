function Z = GPS_msmt(X)
global GPSPVT theta omega_earth c
NS = length(GPSPVT.SP);
Z = nan(1);
R_ECI = X(1:3);
V_ECI = X(4:6);
for i = 1:NS
        gpst = GPSPVT.GPST(2);% -tu_ini;
        PRN = GPSPVT.PRN(i);
        eph = GPSPVT.EPH(:,PRN);
        t_trans = gpst;
        for itr = 1:3
            dt = check_t(t_trans - eph(21));
            t_s = eph(19) + eph(20)*dt + eph(2)*dt^2 - relativistic(t_trans,eph);
            t_trans = gpst - GPSPVT.R(i)/c - t_s;
        end
        %% satellite position
        SP_ECEF = GPSPVT.SP(i,:)';
        SP_ECI = ECEF2ECI(theta,SP_ECEF);
        SPV_ECEF = GPSPVT.SPV(i,:)';
        %V_ECEF = SPV_ECEF + cross(omega_earth,SP_ECEF);
        SPV_ECI = ECEF2ECI(theta,SPV_ECEF + cross(omega_earth,SP_ECEF));
        Z(i,1) = norm(SP_ECI - R_ECI) + X(7) - t_s*c;
        V_rel = SPV_ECI - V_ECI;
        Z(i+ NS,1) = (SP_ECI - R_ECI)'*V_rel/norm(SP_ECI - R_ECI);
end