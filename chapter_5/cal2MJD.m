%% Calender date to MJD and no. of days calculation scince J2000
function [MJD,d] = cal2MJD(DD,MM,YYYY,TT)                                            %DD = day, MM = month, YYYY = yr, TT = [hr min sec]
J2000 = 51544.5;
D = DD + (TT(1) + TT(2)/60 + TT(3)/3600)/24;
if MM<= 2
    Y = YYYY - 1;
    M = MM + 12;
else 
    Y = YYYY;
    M = MM;
end

B = floor(Y/400) - floor(Y/100) + floor(Y/4);
MJD = 365*Y - 679004 + B + floor(30.6001*(M + 1)) + D;
d = MJD - J2000;

