clc
clear all
%% Launch Vehicle Simulation
%States:
%Downrange distance x - X(1)
%Altitude h - X(2)
%Speed v - X(3)
%Flight-path angle lambda - X(4)
%mass m - X(5)
%Aerodynamic Coefficient C - X(6)
%Acceleration - X(7)
%% This simulation is designed for Falcon 9 v1.1 CRS-5 mission
% Global variables
global R_E T g pitch_ctl me_dot dT STG_m_dot dD D sigma_R b phi R_LS lambda prcs_nse
    %% Global constants
R_E = 6378137; %m
b = 6356752.314; %m
lat = deg2rad(28.4889);%N launch lat
lon = deg2rad(-80.5778);%W launch lon
phi = lat;
lambda = lon;
ref_LLA = [lat,lon,0];
R0 = lla2ecef(ref_LLA);
R_LS = R0;
rho = 1.225; %kg/m^3
g = 9.81; %m/s
sigma_R = 50; %m
    %% Vehicle specific constants
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
    %% Initialization
M0 = M-T1/(I_SP1*g)*0.04;
v0 = I_SP1*g*log(M/M0);
D = 0.5*rho*v0^2*A;
t_step = 0.01;
X0 = [0 0 v0 pi/2 M0 0.5 (T1-D)/M0-g];
TIME = 0:S1_burnoutT + S2_burnoutT;
X_LV = nan(length(TIME),length(X0));
X_LV(1,:) = X0;
prcs_nse = [10.*randn(60000,1) 10.*randn(60000,1) 1e-4.*randn(60000,1) ];
%% Propagation
for i = 1:length(TIME)-1
    %% Pitch-over
    if X_LV(i,2) >=Pitch_ctl_alt
       if FPA_flag ==0
           pitch_ctl = pitch_rate;
           FPA_flag = 1;
       else
           pitch_ctl = 0;
       end
    else
       pitch_ctl = 0;
    end
    %% Stage 1 
    if X_LV(i,5) <= M - STG1_PM
        if STG_flag1 ==0
           X_LV(i,5) = X_LV(i,5) - stg1_M;
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
    if X_LV(i,5) <= M - STG1_PM - stg1_M - STG2_PM
       if STG_flag2 ==0
           X_LV(i,5) = X_LV(i,5) - stg2_M;
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
    if X_LV(i,2)>= 30000
        if ATM_flag == 0
            rho = 0;
            dD = -D;
            D = 0.5*rho*X_LV(i,3)^2*A*X_LV(i,6);
            ATM_flag = 1;
        else
            dD = 0;
        end
    else
        dD = 0;
        D = 0.5*rho*X_LV(i,3)^2*A*X_LV(i,6);
    end
    [time, X] = runge_kutta4(@lvdyn_true,[TIME(i) TIME(i+1)],X_LV(i,:)',t_step);
    X_LV(i+1,:) = X(end,:);
end

LV_data.X = X_LV;
%save('LV_data.mat','LV_data')
save('Flight_data.mat','LV_data')
%% Plot

figure('units','normalized','outerposition',[0 0 1 1])
subplot(2,3,1)
plot(TIME,X_LV(:,1)/1000)
grid on
xlabel('TIME (s)')
ylabel('Down-range distance (km)')

subplot(2,3,2)
plot(TIME,X_LV(:,2)/1000)
grid on
xlabel('TIME (s)')
ylabel('Altitude (km)')

subplot(2,3,3)
plot(X_LV(:,1)/1000,X_LV(:,2)/1000)
grid on
xlabel('Down-range distance (km)')
ylabel('Altitude (km)')

subplot(2,3,4)
plot(TIME,X_LV(:,3)/1000)
grid on
xlabel('TIME (s)')
ylabel('Speed (km/s)')

subplot(2,3,5)
plot(TIME,rad2deg(X_LV(:,4)))
grid on
xlabel('TIME (s)')
ylabel('Flight-path angle (deg)')

subplot(2,3,6)
plot(TIME,X_LV(:,5)/1000)
grid on
xlabel('TIME (s)')
ylabel('Mass (Metric ton)')