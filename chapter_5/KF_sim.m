function [EST,m] = KF_sim(obs_data_adrs,SAT_INI,FilterType)
%% Extended/Unscented/ SPU/ ESPU Kalman Filter for satellite navigation in earth bound orbit using GNSS measurements
% data description
% GPSM - PRN, R, RR, GPST (week and second), dt
% PVT_GPS - SP, SPV
% Ref_R_ECEF: True position of satellite in ECEF frame
% Ref_V_ECEF: True velocity of satellite in ECEF frame
% EPH: ephemeris
%%
load(obs_data_adrs) % contains GPSM,PVT_GPS,Ref_R_ECEF,Ref_V_ECEF,EPH
switch FilterType
        case 'EKF'
            filter_alg = @EKF;
        case 'UKF'
            filter_alg = @UKF;
        case 'SPUKF'
            filter_alg = @SPUKF;
        case 'ESPUKF'
            filter_alg = @ESPUKF;
end
%% constants and parameters
global c omega_earth R Qk sigma_a sigma_v GPSPVT theta t_step
c = 299792458; %m/s
omega_earth = [0; 0; 7.2921158553*10^-5];
sigma_R = SAT_INI.sigmar;
sigma_RR = SAT_INI.sigmarr;
L1 = 1575.42*10^6;
if strcmp(FilterType,'EKF') == 1
    Qk = SAT_INI.EKFQk;
else
    Qk = SAT_INI.UKFQk;
end
sigma_a = sqrt(1e-8);
sigma_v = sqrt(1e-8);
t_step = 0.01;
lambda = c/L1;
%NS = SAT_INI.NS;
TIME = 1:SAT_INI.Time;
Ref_R_ECI = nan(length(TIME),3);
Ref_V_ECI = nan(length(TIME),3);
%% Computing initial position using LSQ
start_i = check_visible_sat(GPSM);
[X_lsq,del_rho, del] = lsq_satnav(GPSM(start_i), PVT_GPS(start_i), EPH);
%% Converting reference data in ECI frame
for i = start_i: length(TIME)
    THETA = sha_calc(GPSM(i).GPST);
    Ref_R_ECI(i,:) = ECEF2ECI(THETA, Ref_R_ECEF(i,:)')';
    %V_ECEF = Ref_V_ECEF(i,:)' + cross(omega_earth,Ref_R_ECEF(i,:)');
    Ref_V_ECI(i,:) = ECEF2ECI(THETA,Ref_V_ECEF(i,:)')' + cross(omega_earth,Ref_R_ECI(i,:)')';
end
%% model handling
if strcmp(FilterType,'EKF') == 1
    Sat_model.dynamics = @sat_dynamics;
else
    Sat_model.dynamics = @sat_dynamicsUKF;
end
Sat_model.Fjacobian = @sat_jacobian;
Sat_model.msmtf = @GPS_msmt;
Sat_model.Mjacobian = @GPS_Mjacobian;
%% Filter initialization
X0 = [Ref_R_ECI(1,:) Ref_V_ECI(1,:) X_lsq(4)]' + SAT_INI.del;
STATE = struct([]);
STATE(1).X = X0;
STATE(1).P = diag(SAT_INI.STD.^2);
STATE(1).STD = SAT_INI.STD;
RSDR = [];
RSDV = [];
%% EKF
% figure
% subplot(2,1,1)
% for svn = 1:31
%     r_rsd(svn) = animatedline;
% end
% grid on
% xlabel('Time(s)')
% ylabel('Range resedue (m)')

%subplot(2,1,2)
% for svn = 1:31
%     rr_rsd(svn) = animatedline;
% end
% grid on
% xlabel('Time(s)')
% ylabel('Range rate resedue (m/s)')
profile on
msg1 = sprintf('%s processing started\n',FilterType);
fprintf(msg1);
m = numel(msg1);
for i = 1:length(TIME)-1
    GPSPVT = PVT_GPS(i+1);
    MSMT.PRN = GPSM(i+1).PRN;
    MSMT.Z = [GPSM(i+1).R;GPSM(i+1).RR];
    MSMT.dt = GPSM(i+1).dt;
    theta = sha_calc(GPSM(i+1).GPST);
    NS = length(GPSPVT.SP);
    GPSPVT.EPH = EPH;
    GPSPVT.PRN = GPSM(i+1).PRN;
    GPSPVT.GPST = GPSM(i+1).GPST;
    GPSPVT.R = GPSM(i+1).R;
    %% Constructing R
    R = zeros(2*NS);
    for k = 1:2*NS
        if k<= NS
            R(k,k) = sigma_R^2;
        else
            R(k,k) = sigma_RR^2;
        end
    end
    [state_C, rsd] = filter_alg(STATE(i),MSMT, Sat_model);    
    STATE(i+1).X = state_C.X;
    STATE(i+1).P = state_C.P;
    STATE(i+1).STD = state_C.STD;
    RSDR = [RSDR; rsd(1:NS)];
    RSDV = [RSDV; rsd(NS+1:2*NS)];
%     for svn = 1:length(MSMT.PRN)
%         addpoints(r_rsd(MSMT.PRN(svn)),TIME(i),rsd(svn));
%         addpoints(rr_rsd(MSMT.PRN(svn)),TIME(i),rsd(length(MSMT.PRN) + svn));
%     end
%     drawnow
    prcsd = i/length(TIME)*100;
    msg = sprintf('%s processing: %0.00f percent complete\n',FilterType,prcsd);
    %if rem(prcsd,10) == 0
    fprintf(repmat('\b',1,m));
    fprintf(msg);
    m = numel(msg);
    %end
end
PR = profile('info');
for i = 1:length(STATE)
    EST.X_est(i,:) = STATE(i).X';
    EST.STD(i,:) = STATE(i).STD';
end
EST.extime = extcalc(PR,FilterType);
lngth = length(EST.X_est);
EST.error = [Ref_R_ECI(1:lngth,:) Ref_V_ECI(1:lngth,:)] - EST.X_est(:,1:6);
EST.RSDR = RSDR;
EST.RSDV = RSDV;