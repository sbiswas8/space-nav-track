load 'DATA_IDSN_10S'
load 'DATA_GS_10S'
load 'DATA_MD_10S'
load 'DATA_CB_10S'
load 'atmo'
% load 'Measurement_MD_full_pn10'
% load 'tropospheric_pn10_full'
% anMD = zeros(,1);
% range1_IDSN = range_true_IDSN*1000;
% range1_GS = range_true_GS*1000;
% range1_MD = range_true_MD*1000;
% range1_CB = range_true_CB*1000;
% 
% range_rate_IDSN = V_doppler_IDSN*1000;
% range_rate_GS = V_doppler_GS*1000;
% range_rate_MD = V_doppler_MD*1000;
% range_rate_CB = V_doppler_CB*1000;
rng shuffle
range_noise = 0.1*randn(length(range1_IDSN),1);
%sigma_rr = sqrt(2)*(299792458/1000)*0.1/(2*2*10^9*2*pi*180);
sigma_rr = 1e-6;
range_rate_noise = sigma_rr*randn(length(range_rate_IDSN),1);

an = 1e-3*randn(length(A_meas_IDSN),1); % in deg

elevation_noise = 1e-3*randn(length(E_meas_IDSN),1); %in deg

A_meas_IDSN = A_true_IDSN + an;
E_meas_IDSN = E_true_IDSN + elevation_noise;
range1_IDSN = range_true_IDSN + range_noise;
range_rate_IDSN = range_rate_IDSN/1000 + range_rate_noise; 


A_meas_GS = A_true_GS + an;
E_meas_GS = E_true_GS + elevation_noise;
range1_GS = range_true_GS + range_noise;
range_rate_GS = range_rate_GS/1000 + range_rate_noise; 


A_meas_MD = A_true_MD + an;
E_meas_MD = E_true_MD + elevation_noise;
range1_MD = range_true_MD + range_noise;
range_rate_MD = range_rate_MD/1000 + range_rate_noise;

A_meas_CB = A_true_CB + an;
E_meas_CB = E_true_CB + elevation_noise;
range1_CB = range_true_CB + range_noise;
range_rate_CB = range_rate_CB/1000 + range_rate_noise;

