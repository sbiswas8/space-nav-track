function orbit_plot(obs_data)
load(obs_data)
n = length(Ref_R_ECEF);
Ref_R_ECI = nan(n,3);
k = 1;
for i = 1:100:n
    THETA = sha_calc(GPSM(i).GPST);
    Ref_R_ECI(k,:) = ECEF2ECI(THETA, Ref_R_ECEF(i,:)')';
    k = k+1;
end
plot3(Ref_R_ECI(:,1)/1000, Ref_R_ECI(:,2)/1000, Ref_R_ECI(:,3)/1000,'LineWidth',1.2)