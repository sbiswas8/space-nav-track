function[R_sc3 R_v3 R_m3 R_mv3] = dynamics_prtb(r,r_dot,r_m,r_mdot,t_sim,THETA,t_step)
% R_sc3 = nan(length(t_sim),3);
% R_v3 = nan(length(t_sim),3);
% R_m3 = nan(length(t_sim),3);
X0 = [r r_dot r_m r_mdot]';
[T X] = ode45(@(t,X) dynamics_cowell(t,X,THETA,t_sim),t_sim,X0,t_step);

R_sc3 = X(1:end,1:3);
R_v3 = X(1:end,4:6);
R_m3 = X(1:end,7:9);
R_mv3 = X(1:end,10:12);