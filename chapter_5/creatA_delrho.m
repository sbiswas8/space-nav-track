function [A,del_rho] = creatA_delrho(GPSM,PVT_GPS,EPH,X_ini)
global c
n = length(GPSM.PRN);
A = nan(n,4);
del_rho = nan(n,1);
for i = 1:n
    gpst = GPSM.GPST(2);% -tu_ini;
    PRN = GPSM.PRN(i);
    eph = EPH(:,PRN);
    t_trans = gpst;
    %% Satellite position
    for itr = 1:3
        dt = gps_time_repair(t_trans - eph(21));
        t_s = eph(19) + eph(20)*dt + eph(2)*dt^2 - relativistic(t_trans,eph);
        t_trans = gpst - GPSM.R(i)/c - t_s;
    end
    sat_dat = PVT_GPS.SP(i,:)';
    R_cap  = norm(sat_dat - X_ini(1:3));
    I_vec = [(sat_dat(1) - X_ini(1))/R_cap (sat_dat(2) - X_ini(2))/R_cap (sat_dat(3) - X_ini(3))/R_cap];
    A(i,:) = [I_vec -1];
    del_rho(i,1) = (R_cap + X_ini(4) - t_s*c - GPSM.R(i));
end