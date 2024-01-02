%% Instruction
%1. Run LV_sim
%2. Run Flight_path
%3. Run simgen application
%4. Run this script 
%%
close all
clear all
LV_INI.Q = 1e-30*eye(9);
% LV_INI.Q(1,1) = 1e-50;
% LV_INI.Q(2,2) = 1e-50;
% LV_INI.Q(3,3) = 1e-3;
% LV_INI.Q(4,4) = 1e-5;
% LV_INI.Q(5,5) = 1e-50;
% LV_INI.Q(6,6) = 1e-5;
% LV_INI.Q(7,7) = 1e-6;
% LV_INI.Q(8,8) = 1e-10;
% LV_INI.Q(9,9) = 1e-50;
LV_INI.R = [50 5];
%LV_INI.delX = [0 0 1e-4 1e-8 1e-3 1e-3 1e-2 100 2];
LV_INI.delX = [0 0 .01 1e-8 2 .001 1e-2 100 2];
LV_INI.STD = [1 1 .1 0.001 3 .1 .1 300 5]';
LV_INI.NS = 6;
save('LV_INI.mat','LV_INI')

%run LV_sim
run LV_data_prcs
run LV_EKF
run LV_SPUKF
run LV_ESPUKF
run LV_UKF
run KF_comparision