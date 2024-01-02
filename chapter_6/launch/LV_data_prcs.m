%% Spirent bulk logging csv file processing
%clc
%clear all
%rng(36596191)
data_log = csvread('sat_data_V1A1.csv',2,0);
Ref_data = csvread('CRS_5_log.csv',2,2);
CH= 12;% No. of channels
DL = length(data_log);% data length
dt = 1; % Measurement interval
GPSM = struct([]);
PVT_GPS = struct([]);
for svn = 1:31
    N(svn).RN = 10.*randn(DL/CH,1);
    N(svn).RRN = 1.*randn(DL/CH,1);
end
for i = 1:DL/CH
    k = 1;
    for j = 1:CH
        if data_log((i-1)*CH+j,16)~=0
            GPSM(i).PRN(k) = data_log((i-1)*CH + j,5);
            PVT_GPS(i).SP(k,:) = data_log((i-1)*CH + j,7:9);
            PVT_GPS(i).SPV(k,:) = data_log((i-1)*CH + j,10:12);
            GPSM(i).R(k,1) = data_log((i-1)*CH+j,16) + N(GPSM(i).PRN(k)).RN(i);
            GPSM(i).RR(k,1) = data_log((i-1)*CH+j,19) + N(GPSM(i).PRN(k)).RRN(i);
            GPSM(i).GPST = Ref_data(i,3);
            GPSM(i).dt = dt;
            k = k+1;
        end
    end
end
Ref_R_ECEF = Ref_data(:,2:4);
Ref_V_ECEF = Ref_data(:,5:7);
save('LV_data.mat','GPSM','PVT_GPS','Ref_R_ECEF','Ref_V_ECEF')