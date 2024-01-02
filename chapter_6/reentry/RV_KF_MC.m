clc
clear all
close all

NoR = 50;

for rcnt = 1:NoR
    close all
    run re_entrySim
    %dbstop error
    TIME = 0:200;
    XT_0 = [100000 0 6000 -deg2rad(10) .7]';
    X_INI = XT_0 + [1000 5000 50 0 0]';
    STD_INI = [6000 6000 100 0.1 0.1];
    noise_cov = [50^2 0;0 (deg2rad(0.1))^2];
    process_cov = 10^-10*eye(5);
    save('RV_INI','X_INI', 'STD_INI', 'noise_cov', 'TIME','process_cov')

    run RV_EKF
    run RV_SPUKF
    run RV_ESPUKF
    run RV_UKF
    load RV_EKFdata
    load RV_UKFdata
    load RV_SPUKFdata
    load RV_ESPUKFdata
    
    %if rcnt == 1
    EKF_MC(rcnt).Mean_error = RV_EKFdata.error;
    SPUKF_MC(rcnt).Mean_error = RV_SPUKFdata.error;
    ESPUKF_MC(rcnt).Mean_error = RV_ESPUKFdata.error;
    UKF_MC(rcnt).Mean_error = RV_UKFdata.error;

    EKF_MC(rcnt).Mean_std = RV_EKFdata.STD;
    SPUKF_MC(rcnt).Mean_std = RV_SPUKFdata.STD;
    ESPUKF_MC(rcnt).Mean_std = RV_ESPUKFdata.STD;
    UKF_MC(rcnt).Mean_std = RV_UKFdata.STD;
%     else
%         EKF_MC.Mean_error = EKF_MC.Mean_error + RV_EKFdata.error;
%         SPUKF_MC.Mean_error = SPUKF_MC.Mean_error + RV_SPUKFdata.error;
%         ESPUKF_MC.Mean_error = ESPUKF_MC.Mean_error + RV_ESPUKFdata.error;
%         UKF_MC.Mean_error = UKF_MC.Mean_error + RV_UKFdata.error;
%         
%         EKF_MC.Mean_std = EKF_MC.Mean_std + RV_EKFdata.STD;
%         SPUKF_MC.Mean_std = SPUKF_MC.Mean_std + RV_SPUKFdata.STD;
%         ESPUKF_MC.Mean_std = ESPUKF_MC.Mean_std + RV_ESPUKFdata.STD;
%         UKF_MC.Mean_std = UKF_MC.Mean_std + RV_UKFdata.STD;
%     end
    prcsdf = rcnt/NoR*100;
    clc
    fprintf('%.2f percent processed\n',prcsdf)
end

% EKF_MC.Mean_error = EKF_MC.Mean_error/NoR;
% SPUKF_MC.Mean_error = SPUKF_MC.Mean_error/NoR;
% ESPUKF_MC.Mean_error = ESPUKF_MC.Mean_error/NoR;
% UKF_MC.Mean_error = UKF_MC.Mean_error/NoR;
% 
% EKF_MC.Mean_std = EKF_MC.Mean_std/NoR;
% SPUKF_MC.Mean_std = SPUKF_MC.Mean_std/NoR;
% ESPUKF_MC.Mean_std = ESPUKF_MC.Mean_std/NoR;
% UKF_MC.Mean_std = UKF_MC.Mean_std/NoR;