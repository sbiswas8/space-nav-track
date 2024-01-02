%% Instruction
%1. Run LV_sim
%2. Run Flight_path
%3. Run simgen application
%4. Run this script 
%%
clc
close all
clear all
LV_INI.Q = diag([1e-6 1e-6 1e-4 1e-15 1e-3 1e-6 1e-3 1e-2 1e-2]);
% LV_INI.Q(1,1) = 1e-50;
% LV_INI.Q(2,2) = 1e-50;
% LV_INI.Q(3,3) = 1e-3;
% LV_INI.Q(4,4) = 1e-5;
% LV_INI.Q(5,5) = 1e-50;
% LV_INI.Q(6,6) = 1e-5;
% LV_INI.Q(7,7) = 1e-6;
% LV_INI.Q(8,8) = 1e-10;
% LV_INI.Q(9,9) = 1e-50;
LV_INI.R = [70 10];
LV_INI.delX = [0 0 1e-4 0 1e-3 1e-3 1e-2 1 2];
%LV_INI.delX = [2 3 .01 1e-6 0.001 .001 1e-2 1 2];
LV_INI.STD = [10 10 1 1e-8 1e-3 1e-2 .1 1 5]';
LV_INI.NS = 8;
save('LV_INI.mat','LV_INI')
NoR = 50;
%run LV_sim
for rcnt = 1:NoR
    close all
    %rng(1000)
    run LV_data_prcs
    run LV_EKF
    run LV_SPUKF
    run LV_ESPUKF
    run LV_UKF
    load LV_EKF_data.mat
    load LV_SPUKF_data.mat
    load LV_ESPUKF_data.mat
    load LV_UKF_data.mat

%     if rcnt == 1
    EKF_MC(rcnt).Mean_error = LV_EKF_data.error;
    SPUKF_MC(rcnt).Mean_error = LV_SPUKF_data.error;
    ESPUKF_MC(rcnt).Mean_error = LV_ESPUKF_data.error;
    UKF_MC(rcnt).Mean_error = LV_UKF_data.error;

    EKF_MC(rcnt).Mean_std = LV_EKF_data.STD;
    SPUKF_MC(rcnt).Mean_std = LV_SPUKF_data.STD;
    ESPUKF_MC(rcnt).Mean_std = LV_ESPUKF_data.STD;
    UKF_MC(rcnt).Mean_std = LV_UKF_data.STD;
%     else
%         EKF_MC.Mean_error = EKF_MC.Mean_error + LV_EKF_data.error;
%         SPUKF_MC.Mean_error = SPUKF_MC.Mean_error + LV_SPUKF_data.error;
%         ESPUKF_MC.Mean_error = ESPUKF_MC.Mean_error + LV_ESPUKF_data.error;
%         UKF_MC.Mean_error = UKF_MC.Mean_error + LV_UKF_data.error;
%         
%         EKF_MC.Mean_std = EKF_MC.Mean_std + LV_EKF_data.STD;
%         SPUKF_MC.Mean_std = SPUKF_MC.Mean_std + LV_SPUKF_data.STD;
%         ESPUKF_MC.Mean_std = ESPUKF_MC.Mean_std + LV_ESPUKF_data.STD;
%         UKF_MC.Mean_std = UKF_MC.Mean_std + LV_UKF_data.STD;
%     end
    prcsdf = rcnt/NoR*100;
    clc
    fprintf('%.2f percent processed\n',prcsdf)
end
%save('LV_MR_dataNS8.mat','EKF_MR','SPUKF_MR','ESPUKF_MR','UKF_MR')
%clear all
%load LV_MR_data
EKF_MC.Mean_error = EKF_MC.Mean_error/NoR;
SPUKF_MC.Mean_error = SPUKF_MC.Mean_error/NoR;
ESPUKF_MC.Mean_error = ESPUKF_MC.Mean_error/NoR;
UKF_MC.Mean_error = UKF_MC.Mean_error/NoR;

EKF_MC.Mean_std = EKF_MC.Mean_std/NoR;
SPUKF_MC.Mean_std = SPUKF_MC.Mean_std/NoR;
ESPUKF_MC.Mean_std = ESPUKF_MC.Mean_std/NoR;
UKF_MC.Mean_std = UKF_MC.Mean_std/NoR;