%% Spirent bulk logging csv file processing
function [Ref_R_ECEF, Ref_V_ECEF, GPSM, PVT_GPS, EPH] = sprntdata_rd(sat_data, log_file, rinex_file)
data_log = csvread(sat_data,2,0);
Ref_data = csvread(log_file,3,2);
EPH = rinexe(rinex_file);
clc
f_l1 = 1575.4*10^6;
CH= 12;% No. of channels
DL = length(data_log);% data length
dt = 1; % Measurement interval
GPSM = struct([]);
PVT_GPS = struct([]);
for svn = 1:31
    N(svn).RN = 20.*randn(DL/CH,1);
    N(svn).RRN =1.*randn(DL/CH,1);
end
for i = 1:DL/CH
    k = 1;
    for j = 1:CH
        if data_log((i-1)*CH+j,16)~=0
            GPSM(i).PRN(k) = data_log((i-1)*CH + j,5);
            if GPSM(i).PRN(k) > 30
                GPSM(i).PRN(k) = GPSM(i).PRN(k) -1;
            end
            PVT_GPS(i).SP(k,:) = data_log((i-1)*CH + j,7:9);
            PVT_GPS(i).SPV(k,:) = data_log((i-1)*CH + j,10:12);
            GPSM(i).R(k,1) = data_log((i-1)*CH+j,16) + N(GPSM(i).PRN(k)).RN(i);
            GPSM(i).RR(k,1) = data_log((i-1)*CH+j,19) + N(GPSM(i).PRN(k)).RRN(i);
            GPSM(i).POW(k) = data_log((i-1)*CH + j,25) - 20*log10(GPSM(i).R(k,1)) - 20*log10(f_l1) + 147.55;
            GPSM(i).GPST = [floor(Ref_data(i,1)/(24*3600*7)) rem(Ref_data(i,1),(24*3600*7))];
            GPSM(i).dt = dt;
            k = k+1;
        end
    end
end
Ref_R_ECEF = Ref_data(:,2:4);
Ref_V_ECEF = Ref_data(:,5:7);

% sat_data.Ref_R_ECEF = Ref_R_ECEF;
% sat_data.Ref_V_ECEF = Ref_V_ECEF;
% sat_data.GPSM = GPSM;
% sat_data.PVT_GPS = PVT_GPS;