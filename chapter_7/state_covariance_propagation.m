function [X_prop, cov, P, temp_var] = state_covariance_propagation(R_sc3_ini,R_v3_ini,R_m3_ini,R_mv3_ini,t_sim,t_step, P, pflag)
global d

THETA = (280.4606+360.9856473*(d + t_sim/(3600*24)))*pi/180;
[R_sc3, R_v3, R_m3, R_mv3] = dynamics_prtb(R_sc3_ini,R_v3_ini,R_m3_ini,R_mv3_ini,t_sim,THETA,t_step);
X_prop = [R_sc3 R_v3];
[cov,P,~] = propagate2(R_m3(1:end-2,:),X_prop(1:end-2,:),P,t_step,t_sim);

switch pflag
    case 'full'
        temp_var.R_sc3_ini1 = R_sc3(end,:);
        temp_var.R_v3_ini1 = R_v3(end,:);
        temp_var.R_m3_ini1 = R_m3(end,:);
        temp_var.R_mv3_ini1 = R_mv3(end,:);

        temp_var.R_sc3_ini = R_sc3(end-2,:);
        temp_var.R_v3_ini = R_v3(end-2,:);
        temp_var.R_m3_ini = R_m3(end-2,:);
        temp_var.R_mv3_ini = R_mv3(end-2,:);
        temp_var.Rm = R_m3(end-2:end,:);
        temp_var.Xp = X_prop(end-2:end,:);
    case 'mupdate'
        temp_var.R_m3_ini = R_m3(end,:);
        temp_var.R_mv3_ini = R_mv3(end,:);
end    
X_prop = [R_sc3 R_v3];