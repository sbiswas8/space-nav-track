function H = GPS_Mjacobian(X)
global GPSPVT theta omega_earth
NS = length(GPSPVT.SP);
H = nan(NS*2,7);
R_ECI = X(1:3);
V_ECI = X(4:6);
for i = 1:NS
        SP_ECEF = GPSPVT.SP(i,:)';
        SP_ECI = ECEF2ECI(theta,SP_ECEF);
        SPV_ECEF = GPSPVT.SPV(i,:)';
        %V_ECEF = SPV_ECEF + cross(omega_earth,SP_ECEF);
        SPV_ECI = ECEF2ECI(theta,SPV_ECEF) + cross(omega_earth,SP_ECI);
        R_rel = SP_ECI - R_ECI;
        r = norm(SP_ECI - R_ECI);
        H(i,:) = [1/r*[1 1 1] 0 0 0 1];
        V_rel = SPV_ECI - V_ECI;
        VRH_R = (r^-3*[1 1 1]*(R_rel'*V_rel) - r^-1*V_rel');
        VRH_E = -r^-1*R_rel';
        H(i+NS,:) = [VRH_R VRH_E 0];
end