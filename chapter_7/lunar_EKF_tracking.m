run measurement_processing
run initialisation
wB = waitbar(0,'Progress');
for i = 1:iteration
    obs_info = meaurement_selection(i, IDSN, GS, MD, CB);
    % Propagation
    t_sim = (i-1)*sampt:1:i*sampt;
    t_step = 1;
    [X_prop, cov, P, temp_var1] = state_covariance_propagation(R_sc3_ini,...
        R_v3_ini,R_m3_ini,R_mv3_ini,t_sim,t_step, P, 'full');
    P1 = P;
    covariance((i-1)*sampt + 1:i*sampt-2,:) = cov;
    X_filter((i-1)*sampt+1:i*sampt,:) = X_prop(2:end,:);

    R_sc3_ini = temp_var1.R_sc3_ini;
    R_v3_ini = temp_var1.R_v3_ini;
    R_m3_ini = temp_var1.R_m3_ini;
    R_mv3_ini = temp_var1.R_mv3_ini;

    if obs_info.Elevation > 5*pi/180
        phi = obs_info.phi;
        lambda = obs_info.lambda;
        %% Initialization for next 2s
        C = strcmp(obs_info.flag,flag_prev);
        if C < 1
            count = 0;
        end
        count = count + 1;
        
        t_sim = i*sampt-2: (2 - obs_info.RR_delay)/5 :i*sampt - obs_info.RR_delay;
        t_step = (2 - obs_info.RR_delay)/5;

        [X_prop, cov, P, temp_var2] = state_covariance_propagation(R_sc3_ini,...
            R_v3_ini,R_m3_ini,R_mv3_ini,t_sim,t_step, P, 'mupdate');
        X_priori_RR = X_prop(end,:);
        time_RR = i*sampt - obs_info.RR_delay;

        [State_covariance, X_update, delRR, del_X, KALMAN_GAIN, RC_RR] = RR_UPDATE(X_priori_RR,time_RR,obs_info.phi...
            ,obs_info.lambda,obs_info.Range_Rate,P,R_rr);
        
        state_cov_rr(i,:) = [State_covariance(1,1) State_covariance(2,2) State_covariance(3,3)...
                          State_covariance(4,4) State_covariance(5,5) State_covariance(6,6)];
        
        INNOVATION_RR(i) = delRR;
        K_RR(i,:) = KALMAN_GAIN;
        del_XRR(i,:) = del_X';
        recovRR(i) = RC_RR;
        R_sc3_ini = X_update(1:3);
        R_v3_ini = X_update(4:6);
        R_m3_ini = temp_var2.R_m3_ini;
        R_mv3_ini = temp_var2.R_mv3_ini;

        if count == 10 && C == 1
            % Propagating till RAE measurement
            Z = [obs_info.Range obs_info.Azimuth obs_info.Elevation];
            t_sim = time_RR:(obs_info.RR_delay - obs_info.range_delay)/5:i*sampt - obs_info.range_delay;
            t_step = (obs_info.RR_delay - obs_info.range_delay)/5;
            [X_prop, cov, P, temp_var3] = state_covariance_propagation(R_sc3_ini,...
                R_v3_ini,R_m3_ini,R_mv3_ini,t_sim,t_step, P, 'mupdate');
            X_priori_RAE = X_prop(end,:);
            time_RAE = i*sampt - obs_info.range_delay;
            [State_covariance_RAE, X_update, delRAE, del_X, KALMAN_GAIN_RAE, RC_RAE] = RAE_UPDATE(X_priori_RAE,i*sampt,phi,...
                    lambda,Z,P,R_rae);
            state_cov_r(i,:) = [State_covariance_RAE(1,1) State_covariance_RAE(2,2) State_covariance_RAE(3,3)...
                        State_covariance_RAE(4,4) State_covariance_RAE(5,5) State_covariance_RAE(6,6)];
            INNOVATION_RAE(i,:) = delRAE';
            K_RAE(:,:,i) = KALMAN_GAIN_RAE;
            del_XR(i,:) = del_X(:,1)';
            recovRAE(i,:) = [RC_RAE(1,1) RC_RAE(2,2) RC_RAE(3,3)];
            R_sc3_ini = X_update(1:3);
            R_v3_ini =  X_update(4:6);
            %% Propagation till end of 10s
            t_sim = i*sampt - obs_info.range_delay:obs_info.range_delay/5:i*sampt;
            t_step = obs_info.range_delay/5;
            [X_prop, cov, P, temp_var4] = state_covariance_propagation(R_sc3_ini,...
                R_v3_ini,R_m3_ini,R_mv3_ini,t_sim,t_step, P, 'mupdate');
            X_priori = X_prop(end,:);
            state_cov(i,:) = [P(1,1) P(2,2) P(3,3)...
                              P(4,4) P(5,5) P(6,6)];
            state(i+1,:) = X_priori;
            R_sc3_ini = X_priori(1:3);
            R_v3_ini = X_priori(4:6); 
            R_m3_ini = temp_var4.R_m3_ini;
            R_mv3_ini = temp_var4.R_mv3_ini;

            t_step = 1;
            [cov,~,~] = propagate2(temp_var1.Rm,temp_var1.Xp,P1,t_step,i*sampt-2:1:i*sampt);
            covariance(i*sampt-1:i*sampt,:) = cov;
            
            X_filter(i*sampt,:) = state(i+1,:);
            covariance(i*sampt,:) = state_cov(i,:);
            count = 0;
        else
            %% Propagation till end of 10s
            t_sim = i*sampt - obs_info.RR_delay:obs_info.RR_delay/5:i*sampt;
            t_step = obs_info.RR_delay/5;
            [X_prop, cov, P, temp_var5] = state_covariance_propagation(R_sc3_ini,...
                R_v3_ini,R_m3_ini,R_mv3_ini,t_sim,t_step, P, 'mupdate');
            X_priori = X_prop(end,:);
            state_cov(i,:) = [P(1,1) P(2,2) P(3,3)...
                              P(4,4) P(5,5) P(6,6)];
            state(i+1,:) = X_priori;
            
            R_sc3_ini = X_priori(1:3);
            R_v3_ini = X_priori(4:6); 
            R_m3_ini = temp_var5.R_m3_ini;
            R_mv3_ini = temp_var5.R_mv3_ini;

            t_step = 1;
            [cov,~,~] = propagate2(temp_var1.Rm,temp_var1.Xp,P1,t_step,i*sampt-2:1:i*sampt);
            covariance(i*sampt-1:i*sampt,:) = cov;
            
            X_filter(i*sampt,:) = state(i+1,:);
            covariance(i*sampt,:) = state_cov(i,:);
            flag_prev = obs_info.flag;
        end
    else
        [cov,P,~] = propagate2(temp_var1.Rm,temp_var1.Xp,P,t_step,i*sampt-2:1:i*sampt);
        covariance(i*sampt-1:i*sampt,:) = cov; 
        state(i+1,:) = X_prop(end,:);
        state_cov(i,:) = [P(1,1) P(2,2) P(3,3) P(4,4) P(5,5) P(6,6)];
        
        R_sc3_ini = temp_var1.R_sc3_ini1;
        R_v3_ini = temp_var1.R_v3_ini1;
        R_m3_ini = temp_var1.R_m3_ini1;
        R_mv3_ini = temp_var1.R_mv3_ini1;
    end
    waitbar(i/iteration,wB,sprintf('Simulation %3.2f %% completed',...
        (i/(iteration))*100));
end
delete(wB);
X_filter = [R0 V0;X_filter];
cov_EKF_WD = covariance;
error_EKF = X_true(1:length(X_filter),:) - X_filter;