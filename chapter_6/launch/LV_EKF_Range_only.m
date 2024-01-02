%% LV position and velocity estimation using GPS pseudo-range and range rate measurements
clc
clear all
dbstop error
%dbstop warning
%% Launch Vehicle Simulation
%States:
%Downrange distance x - X(1)
%Altitude h - X(2)
%Speed v - X(3)
%Flight-path angle lambda - X(4)
%mass m - X(5)
%Aerodynamic Coefficient C - X(6)
%Acceleration - X(7)
%Receiver clock bias - X(8)
%Receiver clock drift - X(9)
%% This simulation is designed for Falcon 9 v1.1 CRS-5 mission
% loading measurements and reference data
load LV_data.mat
load LV_INI.mat
load FLT_data.mat
load Flight_data.mat
% Global variables
global R_E T g pitch_ctl me_dot dT STG_m_dot dD D R Qk t_step GPSPVT phi lambda Az R_LS
    %% Global constants
R_E = 6371000; %m
rho = 1.225; %kg/m^3
g = 9.81; %m/s
sigma_R = LV_INI.R(1); %m
sigma_RR = LV_INI.R(2);
RB = sigma_R^2;
Qk = LV_INI.Q;
phi= lat;
lambda = lon;
Az = beta;
R_LS = R0;
%% Vehicle spesific constants
I_SP1 = 282; %s
I_SP2 = 340; %s
d = 3.66; %m
S1_burnoutT = 187;
S2_burnoutT = 386;
T1 = 5886000;%N
T2 = 801000;%N
STG1_PM = 395700; %kg
STG2_PM = 92670; %kg
stg1_M = 23100; %kg
stg2_M = 3900; %kg
Pay_load = 2370 + 4200; %kg
M = STG1_PM + STG2_PM+stg1_M + stg2_M + Pay_load;
A = pi*d^2/4; %frontal area
    %% Flags
STG_flag1 = 0;
STG_flag2 = 0;
FPA_flag = 0;
ATM_flag = 0;

    %% Control sequence
Pitch_ctl_alt = 3000;%m
pitch_rate = -deg2rad(2.2); %rad/s

%% model handling
LV_model.dynamics = @lvdyn;
LV_model.Fjacobian = @LV_Fjacobian;
LV_model.msmtf = @GPS_msmt;
LV_model.Mjacobian = @GPS_Mjacobian;
    %% Initialization
M0 = M-T1/(I_SP1*g)*0.00001;
v0 = I_SP1*g*log(M/M0);
D = rho*v0^2*A*0.5;
t_step = 0.01;
X0 = [0 0 v0 pi/2 M0 0.5 (T1-D)/M0-g 300]';
TIME = 0:0.1:S1_burnoutT + S2_burnoutT;
%STATE.X = nan(length(TIME),length(X0));
%STATE.STD = nan(length(TIME),length(X0));
STATE = struct([]);
STATE(1).P = zeros(length(X0));
STATE(1).X = X0;
STATE(1).STD = LV_INI.STD;
RSD = [];
for i = 1:length(X0)
    STATE(1).P(i,i) = STATE(1).STD(i)^2;
end
%% EKF
figure
plot(LV_data.X(:,1),LV_data.X(:,2))
grid on
est_traj = animatedline;
xlabel('Down-range (m)')
ylabel('Altitude (m)')
for i = 1:length(TIME)- 1
    %% Pitch-over
    if STATE(i).X(2) >=Pitch_ctl_alt
       if FPA_flag ==0
           pitch_ctl = pitch_rate;
           %STATE(i).X = LV_data.X(i,:)';
           FPA_flag = 1;
       else
           pitch_ctl = 0;
       end
    else
       pitch_ctl = 0;
    end
    %% Stage 1 
    if STATE(i).X(5) <= M - STG1_PM
        if STG_flag1 ==0
           STATE(i).X(5) = STATE(i).X(5) - stg1_M;
           STG_m_dot = - stg1_M;
           STG_flag1 = 1;
           dT = T2-T1;
        else
           STG_m_dot = 0;
           dT = 0;
        end
        T = T2;
        me_dot = T2/(I_SP2*g);
    else
        T = T1;
        me_dot = T1/(I_SP1*g);
        STG_m_dot = 0;
        dT = 0;
    end
    %% Stage 2
    if STATE(i).X(5) <= M - STG1_PM - stg1_M - STG2_PM
       if STG_flag2 ==0
           STATE(i).X(5) = STATE(i).X(5) - stg2_M;
           STG_m_dot = - stg2_M;
           dT = -T2;
           STG_flag2 = 1;
       else
            STG_m_dot = 0;
            dT = 0;
       end
       T = 0;
       me_dot = 0;
    end
    %% Atmospheric drag
    if STATE(i).X(2)>= 30000
        if ATM_flag == 0
            rho = 0;
            dD = -D;
            D = 0.5*rho*STATE(i).X(3)^2*A*STATE(i).X(6);
            ATM_flag = 1;
        else
            dD = 0;
        end
    else
        dD = 0;
        D = 0.5*rho*STATE(i).X(3)^2*A*STATE(i).X(6);
    end
    %% Constructing R
    R = zeros(length(GPSM(i).R));
    for k = 1:length(GPSM(i).PRN)
        R(k,k) = RB;
    end
    GPSPVT = PVT_GPS(i);
    MSMT.PRN = GPSM(i).PRN;
    MSMT.Z = GPSM(i).R;
    MSMT.dt = GPSM(i).dt;
    [state_C, rsd] = EKF(STATE(i),MSMT,LV_model);    
    STATE(i+1).X = state_C.X;
    STATE(i+1).P = state_C.P;
    STATE(i+1).STD = state_C.STD;
    RSD = [RSD;rsd];
    
    %addpoints(true_traj,LV_data.X(i,1),LV_data.X(i,2));
    addpoints(est_traj,state_C.X(1),state_C.X(2));
    drawnow
end

for i = 1:length(STATE)
    EST.X_est(i,:) = STATE(i).X';
    EST.STD(i,:) = STATE(i).STD';
end