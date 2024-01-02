%% Reenrtry simulation
clc
%clear all
close all
global m R M
m = 4000;
X_0 = [100000 0 6000 -deg2rad(10) .7];

t = 0:1:200;
X_re(1,:) = X_0;
for i = 1:length(t)-1
    [T,X] = runge_kutta4(@Trentrydyn,[t(i) t(i+1)],X_re(i,:)',1/100);
    X_re(i+1,:) = X(end,:);
end
%% Radar measurements
R = 6371*10^3; %Radius of earth in m
M = 10*10^3; % down-range of the radar

Phi = (M-X_re(:,2))/R;
dH = R - R.*cos(Phi);
dD = R.*sin(Phi);
%rng('shuffle')
r_noise = 50*randn(length(X_re),1);
e_noise = deg2rad(.1)*randn(length(X_re),1);
r = sqrt((X_re(:,1)+dH).^2 + dD.^2)+ r_noise;
e = pi - (atan2((X_re(:,1) +dH),dD) - Phi) + e_noise;
Z = [r';e'];

Rentry_Tdata.Tstate = X_re;
Rentry_Tdata.measurement = Z;
save Rentry_Tdata Rentry_Tdata
%%
figure
%subplot(3,2,1)
plot(X_re(:,2)/1000,X_re(:,1)/1000,'k','LineWidth',1.5)
set(gca,'FontSize',17,'FontName','Times New Roman')
grid on
xlabel('Down-range (km)','FontSize',17,'FontName','Times New Roman')
ylabel('Altitude (km)','FontSize',17,'FontName','Times New Roman')
print('crv_trajectory','-depsc','-tiff')

figure
%subplot(3,2,2)
plot(t,X_re(:,1)/1000,'k','LineWidth',1.5)
set(gca,'FontSize',17,'FontName','Times New Roman')
grid on
xlabel('Time (s)','FontSize',17,'FontName','Times New Roman')
ylabel('Altitude (km)','FontSize',17,'FontName','Times New Roman')


figure
%subplot(3,2,3)
plot(t,X_re(:,2)/1000,'k','LineWidth',1.5)
set(gca,'FontSize',17,'FontName','Times New Roman')
grid on
xlabel('Time (s)','FontSize',17,'FontName','Times New Roman')
ylabel('Down-range (km)','FontSize',17,'FontName','Times New Roman')

figure
%subplot(3,2,4)
plot(t,X_re(:,3)/1000,'k','LineWidth',1.5)
set(gca,'FontSize',17,'FontName','Times New Roman')
grid on
xlabel('Time (s)','FontSize',17,'FontName','Times New Roman')
ylabel('Velocity (km/s)','FontSize',17,'FontName','Times New Roman')
print('crv_vel','-depsc','-tiff')
figure
%subplot(3,2,5)
plot(t,rad2deg(X_re(:,4)),'k','LineWidth',1.5)
set(gca,'FontSize',17,'FontName','Times New Roman')
grid on
xlabel('Time (s)','FontSize',17,'FontName','Times New Roman')
ylabel('Flight path angle (deg)','FontSize',17,'FontName','Times New Roman')
print('crv_fpa','-depsc','-tiff')

figure
%subplot(3,2,6)
plot(t,X_re(:,5)-.7,'k','LineWidth',1.5)
%ylim([7*10^-7 7*10^-6])
set(gca,'FontSize',17,'FontName','Times New Roman')
grid on
xlabel('Time (s)','FontSize',17,'FontName','Times New Roman')
ylabel('Change in Aerodynamic Co-efficient','FontSize',17,'FontName','Times New Roman')
print('crv_C','-depsc','-tiff')