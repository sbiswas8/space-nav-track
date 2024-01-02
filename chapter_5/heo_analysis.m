function [EKF, UKF, SPUKF, ESPUKF] = heo_analysis(data)
EKF = struct([]);
UKF = struct([]);
SPUKF = struct([]);
ESPUKF = struct([]);
for i = 1:length(data)
    EKF(i).rmser = rms(snorm(data(i).EKF.error(:,1:3)));
    EKF(i).rmsev = rms(snorm(data(i).EKF.error(:,4:6)));
    EKF(i).ex_t = data(i).EKF.extime;
    
    UKF(i).rmser = rms(snorm(data(i).UKF.error(:,1:3)));
    UKF(i).rmsev = rms(snorm(data(i).UKF.error(:,4:6)));
    UKF(i).ex_t = data(i).UKF.extime;
    
    SPUKF(i).rmser = rms(snorm(data(i).SPUKF.error(:,1:3)));
    SPUKF(i).rmsev = rms(snorm(data(i).SPUKF.error(:,4:6)));
    SPUKF(i).ex_t = data(i).SPUKF.extime;
    
    ESPUKF(i).rmser = rms(snorm(data(i).SPUKF.error(:,1:3)));
    ESPUKF(i).rmsev = rms(snorm(data(i).ESPUKF.error(:,4:6)));
    ESPUKF(i).ex_t = data(i).SPUKF.extime;
end