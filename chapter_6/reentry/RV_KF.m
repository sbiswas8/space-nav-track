%% Re-entry Kalman Filters
clc
clear all
close all
%rng('shuffle')
run re_entrySim
%dbstop error
TIME = 0:200;
XT_0 = [100000 0 6000 -deg2rad(10) .7]';
X_INI = XT_0 + [1000 5000 50 0 0]';
STD_INI = [6000 6000 100 0.1 0.1];
noise_cov = [100^2 0;0 (deg2rad(1))^2];
process_cov = 10^-15*eye(5);
save('RV_INI','X_INI', 'STD_INI', 'noise_cov', 'TIME','process_cov')

run RV_EKF
run RV_SPUKF
run RV_ESPUKF
run RV_UKF
run RV_KF_comp