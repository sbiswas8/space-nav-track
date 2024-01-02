function [X_lsq,del_rho, del] = lsq_satnav(gpsm,pvt_gps,eph)
X_ini = [0 0 0 0]';
for i = 1:10
    [A,del_rho] = creatA_delrho(gpsm,pvt_gps,eph,X_ini);
    [X_ini, del] = lsq(A,del_rho,X_ini);
end
X_lsq = X_ini;