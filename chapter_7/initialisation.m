global d
P = [(3)^2*eye(3) zeros(3);
     zeros(3) (0.01)^2*eye(3)];
PP = P; 
sigma_A = deg2rad(1e-3);
sigma_E = deg2rad(1e-3);
sigma_R = 0.1;
R_rae = [sigma_R sigma_A 2*sigma_E]*2;
R_rr = (sigma_rr*2)^2; 
d = 55804 - 51544.5 + 20;

sampt = 10;
meas_sampt = 5;
iteration = 20082;

%Initialization

load X_RM
load X_m
R_sc3 = X_RM(:,1:3);
R_v3 = X_RM(:,4:6);
R_m3 = X_m(:,1:3);
R_mv3 = X_m(:,4:6);
clear X_RM
clear X_m

%Variables
state_cov_rr = zeros(iteration,6);
state_cov_r = zeros(iteration,6);
INNOVATION_RR = nan(iteration,1);
INNOVATION_RAE = zeros(iteration,3);
state_cov = zeros(iteration - 1,6);
state = zeros(iteration,6);
Z_CAP_RAE = zeros(iteration,3);
Z_CAP_RR = zeros(iteration,1);
K_RR = nan(iteration,6);
K_RAE = nan(6,3,iteration);
X_filter = nan(iteration*sampt,6);
covariance = nan(iteration*sampt,6);
del_XR = nan(iteration,6);
del_XA = nan(iteration,6);
del_XE = nan(iteration,6);
del_XRR = nan(iteration,6);
recovRR = nan(iteration,1);
recovRAE = nan(iteration,3);
R_XYZ = nan(iteration,3);
X_true = [R_sc3 R_v3];
 
R0 = R_sc3(1,:) - [3 -1 0.2];
V0 = R_v3(1,:) - [0.001 0.01 0.001];
state(1,:) = X_true(1,:);
flag_prev = 'none';
count = 0;
R_sc3_ini = R0;
R_v3_ini = V0;
R_m3_ini = R_m3(1,:);
R_mv3_ini = R_mv3(1,:);

clear R_sc3
clear R_v3
clear R_m3
clear R_mv3