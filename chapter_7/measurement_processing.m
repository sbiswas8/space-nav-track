load 'DATA_IDSN_10S'
load 'DATA_GS_10S'
load 'DATA_MD_10S'
load 'DATA_CB_10S'
load 'atmo'
load 'delay_IDSN_10S'
load 'delay_GS_10S'
load 'delay_MD_10S'
load 'delay_CB_10S'

rng shuffle
range_noise = 0.1*randn(length(range1_IDSN),1);
%sigma_rr = sqrt(2)*(299792458/1000)*0.1/(2*2*10^9*2*pi*180);
sigma_rr = 1e-6;
range_rate_noise = sigma_rr*randn(length(range_rate_IDSN),1);

an = 1e-3*randn(length(A_meas_IDSN),1); % in deg

elevation_noise = 1e-3*randn(length(E_meas_IDSN),1); %in deg

IDSN.A_meas = A_true_IDSN + an;
IDSN.E_meas = E_true_IDSN + elevation_noise;
IDSN.range1 = range_true_IDSN + range_noise;
IDSN.range_rate = range_rate_IDSN/1000 + range_rate_noise; 
IDSN.TAU = TAU_IDSN;
IDSN.tau_up1 = tao_up1_IDSN;
IDSN.tau_down1 = tao_down1_IDSN;
IDSN. phi = (12.901631)*pi/180; %Byalalu
IDSN.lambda = (77.368619)*pi/180;%Byalalu

GS.A_meas = A_true_GS + an;
GS.E_meas = E_true_GS + elevation_noise;
GS.range1 = range_true_GS + range_noise;
GS.range_rate = range_rate_GS/1000 + range_rate_noise;
GS.TAU = TAU_GS;
GS.tau_up1 = tao_up1_GS;
GS.tau_down1 = tao_down1_GS;
GS.phi = (35.426667)*pi/180; %Goldstone
GS.lambda = (-116.89)*pi/180;%Goldstone


MD.A_meas = A_true_MD + an;
MD.E_meas = E_true_MD + elevation_noise;
MD.range1 = range_true_MD + range_noise;
MD.range_rate = range_rate_MD/1000 + range_rate_noise;
MD.TAU = TAU_MD;
MD.tau_up1 = tao_up1_MD;
MD.tau_down1 = tao_down1_MD;
MD.phi = (40.431389)*pi/180; %Madrid
MD.lambda = (-4.248056)*pi/180;%Madrid

CB.A_meas = A_true_CB + an;
CB.E_meas = E_true_CB + elevation_noise;
CB.range1 = range_true_CB + range_noise;
CB.range_rate = range_rate_CB/1000 + range_rate_noise;
CB.TAU = TAU_CB;
CB.tau_up1 = tao_up1_CB;
CB.tau_down1 = tao_down1_CB;
CB.phi = (-35.401389)*pi/180; %Canberra
CB.lambda = (148.981667)*pi/180;%Canberra