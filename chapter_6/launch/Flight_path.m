 %% LAunch vehicle Initial Flight Path Angle Calculation
clc
clear all
load Flight_data.mat
%% Global constants
global G M R_E phi lambda Az R_LS b
G = 6.67408*10^-11;% m3 kg-1 s-2
M = 5.972*10^24; %kg
R_E = 6378137; % m
b = 6356752.314; %m
%% Launching details 
Orb_alt = 600;%orbit altitiude in km
lat = deg2rad(28.4889);%N launch lat
lon = deg2rad(-80.5778);%W launch lon
phi = lat;
lambda = lon;
orb_inc = deg2rad(51.65); %orbit inclination (deg)
alt_F = 409; %km (final altitude)
dt = 1;
%% Initial and final state calculation
beta = asin(cos(orb_inc)/cos(lat)); %launch azimuth
Az = beta;
v_F = sqrt(G*M/(R_E+ alt_F*1000)); %Final velocity in orbit
ref_LLA = [lat,lon,0];
R0 = lla2ecef(ref_LLA);
R_LS = R0;
LV_R_ECEF = nan(length(LV_data.X),3);
LV_V_ECEF = nan(length(LV_data.X),3);
for i = 1:length(LV_data.X)
    [R_ECEF,V_ECEF] = Co_ord_change(LV_data.X(i,:));
    LV_R_ECEF(i,:) = R_ECEF;
    LV_V_ECEF(i,:) = V_ECEF;
end
FPA = LV_data.X(:,4);
acc = derv(LV_V_ECEF,1);
ws = 10;
B = (1/ws)*ones(1,ws);
accf = filter(B,1,acc);
jerk = derv(acc,1);
jerkf = filter(B,1,jerk);
acc = [acc(1,:); acc];
jerkf = [jerkf(1,:);jerkf(1,:);jerkf];
for ct = 1:length(jerkf)-1
    for c = 1:3
        if abs(jerkf(ct,c)- jerkf(ct+1,c))>=.33
            jerkf(ct+1,c) = 0;
        end
    end
end
save('FLT_data.mat','lat','lon','beta','R0','LV_R_ECEF','LV_V_ECEF')
%% UMT Generation
fid = fopen('D:\Sanat\Dropbox\PhD\Spirent\LV_Simulation\CRS_5\LV_motion.umt','w');
%fid = fopen('C:\Users\Sanat\Dropbox\PhD\Spirent\LV_Simulation\CRS_5\LV_motion.umt','w');
UMT_GEN(LV_R_ECEF,LV_V_ECEF,dt,fid)