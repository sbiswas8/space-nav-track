clc
%clear all
close all
%% Re-entry vehicle position estimation program
load Rentry_Tdata % true trajectory and measurements
load RV_INI
global m R_e M Qk t_step R
m = 4000;
R_e = 6371*10^3; %Radius of earth in m
M = 10*10^3; % down-range of the radar
t_step = 0.1;
Qk = process_cov;
R = noise_cov;
X_true = Rentry_Tdata.Tstate;
Z = Rentry_Tdata.measurement;

STATE = struct([]);

STATE(1).X = X_INI;
STATE(1).STD = STD_INI;
STATE(1).P = zeros(5);
STATE(1).K = 0;
for i = 1:length(X_INI)
    STATE(1).P(i,i) = STD_INI(i)^2;
end
X_est(1,:) = X_INI;
std(1,:) = STD_INI;
RVMODEL.dynamics = @rentrydyn;
RVMODEL.msmtf = @h_rentry;
RVMODEL.Fjacobian = @rentryjacobian;
RVMODEL.Mjacobian = @rentry_mjacobian;
time = TIME;
RSD = [];
fprintf('Estimating position')
profile on
for i = 1:length(time)-1
    msmt.Z = Z(:,i+1);
    msmt.dt =1;
    [statec , rsd] = EKF(STATE(i),msmt,RVMODEL);
    STATE(i+1).X = statec.X;
    STATE(i+1).P = statec.P;
    STATE(i+1).STD = statec.STD;
    STATE(i+1).K = statec.K;
    RSD = [RSD rsd];
    X_est(i+1,:) = statec.X';
    std(i+1,:) = statec.STD;
    prcsd = i/time(end)*100;
    clc
    fprintf('%.0f percent processed\n',prcsd)
end
PR = profile('info');
profile off
error = X_true - X_est;
RV_EKFdata.X = X_est;
RV_EKFdata.STD = std;
RV_EKFdata.error = error;
RV_EKFdata.profile = PR;
%save RV_EKFdata RV_EKFdata
