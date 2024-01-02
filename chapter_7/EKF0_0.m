clc
clear all
close all
run measurement_noise
load 'delay_IDSN_10S'
load 'delay_GS_10S'
load 'delay_MD_10S'
load 'delay_CB_10S'

P = [(3)^2*eye(3) zeros(3);
     zeros(3) (0.01)^2*eye(3)];
PP = P; 
sigma_A = deg2rad(0.1);
sigma_E = deg2rad(0.1);
sigma_R = 0.5;
R_rae = [sigma_R sigma_A sigma_E];
R_rr = (sigma_rr)^2; 
d = 55804 - 51544.5 + 20;

sampt = 10;
meas_sampt = 5;
iteration = 3600;  %20082;

%**************************************************************************
%Initialization
%**************************************************************************
load 'trajectory'

%%
 %*************************************************************************
 %Variables
 %*************************************************************************
 state_cov_rr = zeros(iteration,6);
 state_cov_r = zeros(iteration,6);
 INNOVATION_RR = zeros(iteration,1);
 INNOVATION_RAE = zeros(iteration,3);
 state_cov = zeros(iteration - 1,6);
 state = zeros(iteration,6);
 Z_CAP_RAE = zeros(iteration,3);
 Z_CAP_RR = zeros(iteration,1);
 K_RR = zeros(iteration,6);
 K_RAE = zeros(6,3,iteration);
 X_filter = nan(iteration*sampt,6);
 covariance = nan(iteration*sampt,6);
 del_XRAE = nan(iteration,6);
 del_XRR = nan(iteration,6);
 recovRR = nan(iteration,1);
 recovRAE = nan(iteration,3);
 R_XYZ = nan(iteration,3);
  %%
X_true = [R_sc3 R_v3];
 
R0 = R_sc3(1,:);% - [1 1 1];
V0 = R_v3(1,:);% - [0.01 0.01 0.01];
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

wB = waitbar(0,'Simulating');
for i = 1:iteration
    %**********************************************************************
    %Propagation
    %**********************************************************************
    t_sim = (i-1)*sampt:1:i*sampt;
    t_step = 1;
    
    THETA = (280.4606+360.9856473*(d + t_sim/(3600*24)))*pi/180;
    [R_sc3 R_v3 R_m3 R_mv3] = dynamics_prtb(R_sc3_ini,R_v3_ini,R_m3_ini,R_mv3_ini,t_sim,THETA,t_step);
    
    R_sc3_ini1 = R_sc3(end,:);
    R_v3_ini1 = R_v3(end,:);
    R_m3_ini1 = R_m3(end,:);
    R_mv3_ini1 = R_mv3(end,:);
    
    R_sc3_ini = R_sc3(end-2,:);
    R_v3_ini = R_v3(end-2,:);
    R_m3_ini = R_m3(end-2,:);
    R_mv3_ini = R_mv3(end-2,:);
    
    X_prop = [R_sc3 R_v3];
    [cov,P,~] = propagate(R_m3(1:end-2,:),X_prop(1:end-2,:),P,t_step,t_sim);
    P1 = P;
    covariance((i-1)*sampt + 1:i*sampt-2,:) = cov;
    X_filter((i-1)*sampt+1:i*sampt,:) = X_prop(2:end,:);
    
    Rm = R_m3(end-2:end,:);
    Xp = X_prop(end-2:end,:);
    
    clear R_sc3
    clear R_v3
    clear R_m3
    clear R_mv3
    
    %%
    %**********************************************************************
    %Estimation
    %**********************************************************************
    if E_meas_GS(i) > 10
            Azimuth = A_meas_GS(i)*pi/180;
            Elevation = E_meas_GS(i)*pi/180;
            Range = range1_GS(i);
            Range_Rate = range_rate_GS(i);
            
            phi = (35.426667)*pi/180; %Goldstone
            lambda = (-116.89)*pi/180;%Goldstone
            
            RR_delay = TAU_GS(i);
            range_delay = (tao_up1_GS(i) + tao_down1_GS(i))/2;
            flag = 'GS';
    else
        if E_meas_MD(i) > 10
                Azimuth = A_meas_MD(i)*pi/180;
                Elevation = E_meas_MD(i)*pi/180;
                Range = range1_MD(i);
                Range_Rate = range_rate_MD(i);

                phi = (40.431389)*pi/180; %Madrid
                lambda = (-4.248056)*pi/180;%Madrid

                RR_delay = TAU_MD(i);
                range_delay = (tao_up1_MD(i) + tao_down1_MD(i))/2;
                flag = 'MD';
        else
            if E_meas_IDSN(i)> 10       
                    Azimuth = A_meas_IDSN(i)*pi/180;
                    Elevation = E_meas_IDSN(i)*pi/180;
                    Range = range1_IDSN(i);
                    Range_Rate = range_rate_IDSN(i);

                    phi = (12.901631)*pi/180; %Byalalu
                    lambda = (77.368619)*pi/180;%Byalalu

                    range_delay = (tao_up1_IDSN(i) + tao_down1_IDSN(i))/2;
                    RR_delay = TAU_IDSN(i);
                    flag = 'IDSN';
            else
                if E_meas_CB(i) > 10
                    Azimuth = A_meas_CB(i)*pi/180;
                    Elevation = E_meas_CB(i)*pi/180;
                    Range = range1_CB(i);
                    Range_Rate = range_rate_CB(i);

                    phi = (-35.401389)*pi/180; %Canberra
                    lambda = (148.981667)*pi/180;%Canberra

                    RR_delay = TAU_CB(i);
                    range_delay = (tao_up1_CB(i) + tao_down1_CB(i))/2;
                    flag = 'CB';
                    
                else
                    Elevation = 0;
                end
            end
        end
    end
    %%
    if Elevation > 5*pi/180
        %% Initialization for next 2s
        C = strcmp(flag,flag_prev);
        if C < 1
            count = 0;
        end
        count = count + 1;
        
        t_sim = i*sampt-2: (2 - RR_delay)/5 :i*sampt - RR_delay;
        t_step = (2 - RR_delay)/5;
        
        THETA = (280.4606+360.9856473*(d + t_sim/(3600*24)))*pi/180;
        [R_sc3 R_v3 R_m3 R_mv3] = dynamics_prtb(R_sc3_ini,R_v3_ini,R_m3_ini,R_mv3_ini,t_sim,THETA,t_step);
        
        X_prop = [R_sc3 R_v3];
        [~,P,~] = propagate(R_m3,X_prop,P,t_step,t_sim);
        
        X_priori_RR = X_prop(end,:);
        time_RR = i*sampt - RR_delay;
        
        R_m3_ini = R_m3(end,:);
        R_mv3_ini = R_mv3(end,:);
        
        clear R_sc3
        clear R_v3
        clear R_m3
        clear R_mv3
        %% Range Rate Update
        %******************************************************************
        [State_covariance X_update delRR del_X KALMAN_GAIN RC_RR] = RR_UPDATE(X_priori_RR,time_RR,phi...
            ,lambda,Range_Rate,P,R_rr);
        
        state_cov_rr(i,:) = [State_covariance(1,1) State_covariance(2,2) State_covariance(3,3)...
                          State_covariance(4,4) State_covariance(5,5) State_covariance(6,6)];
        
        INNOVATION_RR(i) = delRR;
        K_RR(i,:) = KALMAN_GAIN;
        del_XRR(i,:) = del_X';
        recovRR(i) = RC_RR;
        
        R_sc3_ini = X_update(1:3);
        R_v3_ini = X_update(4:6);
        
        if count == 10 && C == 1
            %% Propagation till time corresponding to range measurement
            %******************************************************************
            % Propagating till RAE measurement
            t_sim = time_RR:(RR_delay - range_delay)/5:i*sampt - range_delay;
            t_step = (RR_delay - range_delay)/5;
            
            THETA = (280.4606+360.9856473*(d + t_sim/(3600*24)))*pi/180;
            [R_sc3 R_v3 R_m3 R_mv3] = dynamics_prtb(R_sc3_ini,R_v3_ini,R_m3_ini,R_mv3_ini,t_sim,THETA,t_step);
            
            X_prop = [R_sc3 R_v3];
            [~,P,~] = propagate(R_m3,X_prop,State_covariance,t_step,t_sim);
            X_priori_RAE = X_prop(end,:);
            time_RAE = i*sampt - range_delay;
            
            R_m3_ini = R_m3(end,:);
            R_mv3_ini = R_mv3(end,:);
            
            clear R_sc3
            clear R_v3
            clear R_m3
            clear R_mv3
            
            %% Range, Azimuth and Elevation Update
        %******************************************************************
        Z = [Range Azimuth Elevation];    
        [State_covariance_RAE X_update delRAE del_X KALMAN_GAIN_RAE RC_RAE] = RAE_UPDATE(X_priori_RAE,time_RAE,phi,...
            lambda,Z,P,R_rae);
        
        state_cov_r(i,:) = [State_covariance_RAE(1,1) State_covariance_RAE(2,2) State_covariance_RAE(3,3)...
                              State_covariance_RAE(4,4) State_covariance_RAE(5,5) State_covariance_RAE(6,6)];
        INNOVATION_RAE(i,:) = delRAE';
        
        %             Z_CAP_RAE(i,:) = z_cap_RAE;
%              K_RAE(:,:,i) = KALMAN_GAIN_RAE;
%              del_XRAE(i,:) = del_X';
%              R_XYZ(i,:) = [Rxyz(1,1) Rxyz(2,2) Rxyz(3,3)];
             %recovRAE(i,:) = RC_RAE;
             
        R_sc3_ini = X_update(1:3);
        R_v3_ini = X_update(4:6); 
        
        %% Propagation till end of 10s
            %**************************************************************  
            t_sim = i*sampt - range_delay:range_delay/5:i*sampt;
            t_step = range_delay/5;
            
            THETA = (280.4606+360.9856473*(d + t_sim/(3600*24)))*pi/180;
            [R_sc3 R_v3 R_m3 R_mv3] = dynamics_prtb(R_sc3_ini,R_v3_ini,R_m3_ini,R_mv3_ini,t_sim,THETA,t_step);
            
            X_prop = [R_sc3 R_v3];
            [~,P,~] = propagate(R_m3,X_prop,State_covariance_RAE,t_step,t_sim);
            X_priori = [R_sc3(size(R_sc3,1),:) R_v3(size(R_v3,1),:)];
            
            
            state_cov(i,:) = [P(1,1) P(2,2) P(3,3)...
                              P(4,4) P(5,5) P(6,6)];
            state(i+1,:) = X_priori;
            
            R_sc3_ini = X_priori(1:3);
            R_v3_ini = X_priori(4:6); 
            R_m3_ini = R_m3(end,:);
            R_mv3_ini = R_mv3(end,:);
            
            clear R_sc3
            clear R_v3
            clear R_m3
            clear R_mv3
            
            t_step = 1;
            
            [cov,~,~] = propagate(Rm,Xp,P1,t_step,i*sampt-2:1:i*sampt);
            covariance(i*sampt-1:i*sampt,:) = cov;
            
            X_filter(i*sampt,:) = state(i+1,:);
            covariance(i*sampt,:) = state_cov(i,:);
            count = 0;
        else
            %% Propagation till end of 10s
            %**************************************************************  
            t_sim = i*sampt - RR_delay:RR_delay/5:i*sampt;
            t_step = RR_delay/5;
            
            THETA = (280.4606+360.9856473*(d + t_sim/(3600*24)))*pi/180;
            [R_sc3 R_v3 R_m3 R_mv3] = dynamics_prtb(R_sc3_ini,R_v3_ini,R_m3_ini,R_mv3_ini,t_sim,THETA,t_step);
            
            X_prop = [R_sc3 R_v3];
            [~,P,~] = propagate(R_m3,X_prop,State_covariance,t_step,t_sim);
            X_priori = [R_sc3(size(R_sc3,1),:) R_v3(size(R_v3,1),:)];
            
            state_cov(i,:) = [P(1,1) P(2,2) P(3,3)...
                              P(4,4) P(5,5) P(6,6)];
            state(i+1,:) = X_priori;
            
            R_sc3_ini = X_priori(1:3);
            R_v3_ini = X_priori(4:6); 
            R_m3_ini = R_m3(end,:);
            R_mv3_ini = R_mv3(end,:);
            
            clear R_sc3
            clear R_v3
            clear R_m3
            clear R_mv3
            t_step = 1;
            
            [cov,~,~] = propagate(Rm,Xp,P1,t_step,i*sampt-2:1:i*sampt);
            covariance(i*sampt-1:i*sampt,:) = cov;
            X_filter(i*sampt,:) = state(i+1,:);
                covariance(i*sampt,:) = state_cov(i,:);
                flag_prev = flag;
        end
    else
        [cov,P,~] = propagate(Rm,Xp,P,t_step,i*sampt-2:1:i*sampt);
        covariance(i*sampt-1:i*sampt,:) = cov; 
        state(i+1,:) = X_prop(end,:);
        state_cov(i,:) = [P(1,1) P(2,2) P(3,3) P(4,4) P(5,5) P(6,6)];
        
        R_sc3_ini = R_sc3_ini1;
        R_v3_ini = R_v3_ini1;
        R_m3_ini = R_m3_ini1;
        R_mv3_ini = R_mv3_ini1;
    end
    
    waitbar(i/iteration,wB,sprintf('Simulation %3.2f %% completed',...
        (i/(iteration))*100));
end
delete(wB);
X_filter = [X_true(1,:);X_filter];
cov_EKF_WD = state_cov;