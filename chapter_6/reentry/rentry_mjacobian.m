function H = rentry_mjacobian(X)
global R_e M
%%
h = X(1);
d = X(2);
%%
phi = (M-d)/R_e;
theta = (h+R_e-R_e*cos(phi))/R_e*sin(phi);
r= sqrt((h+R_e-R_e*cos(phi))^2 + (R_e*sin(phi))^2);

delr_delh = 1/r*(h+R_e-R_e*cos(phi));
delr_deld = -1/r*(h+R_e)*sin(phi);

delE_delh = -1/(1+theta^2)*(1-cos(phi))/sin(phi);
delE_deld = -1/(1+theta^2)*((h+R_e-R_e*cos(phi))*cos(phi)/(R_e*sin(phi))^2 - 1/R_e);

H = [delr_delh delr_deld 0 0 0; delE_delh delE_deld 0 0 0];
