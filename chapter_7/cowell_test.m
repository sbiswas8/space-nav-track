clc
clear all

r = [3651.43427447696,-5171.26690948602,-1797.60169198044];
r_dot = [9.07267293954542,5.36459442529173,3.04195623958456];

% r = [3652.93427447695 -5169.76690948601 -1796.10169198043];
% r_dot = [9.07317293954542,5.36509442529173,3.04245623958456];
r_m = [67612.4015035788,347637.082871069,149474.707508704];
r_mdot = [-1.00491171614312 0.199675792437511 -0.00976323065102094];

d = 55804 - 51544.5 + 20;
t_sim = 0:1:200830;
t_step = 1;
% THETA = (280.4606+360.9856473*(d + t_sim/(3600*24)))*pi/180;
% [R_sc3_C R_v3_C R_m3_C R_mv3_C] = dynamics_prtb(r,r_dot,r_m,r_mdot,t_sim,THETA,t_step);

sampt = 10;
for i=1:20083
    t_sim = (i-1)*sampt:i*sampt;
    t_step = 1;
    THETA = (280.4606+360.9856473*(d + t_sim/(3600*24)))*pi/180;
    [R_sc3 R_v3 R_m3 R_mv3] = dynamics_prtb(r,r_dot,r_m,r_mdot,t_sim,THETA,t_step);
    r = R_sc3(end,:);
    r_dot = R_v3(end,:);
    r_m = R_m3(end,:);
    r_mdot = R_mv3(end,:);
    X_filter((i-1)*sampt+1:i*sampt+1,:)= [R_sc3 R_v3];
    X_m((i-1)*sampt+1:i*sampt+1,:) = [R_m3 R_mv3];
end