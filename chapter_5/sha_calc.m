function THETA = sha_calc(GPST)
% this function computes SHA from GPS time
leapsec = 0;
UTC_start = gps2utc([GPST(1)-1024 GPST(2)],leapsec);
MJD_start = cal2MJD(UTC_start(3),UTC_start(2),UTC_start(1),[0 0 0]);
start_sec = UTC_start(4)*3600 + UTC_start(5)*60 + UTC_start(6);
d_start = MJD_start + start_sec/86400 - 51544.5;
THETA = deg2rad(280.4606+360.9856473*d_start);
