clc
clear all
load RV_EKFdata
load RV_SPUKFdata
load RV_ESPUKFdata
load RV_UKFdata
load RV_INI

subplot(3,1,1)
plot(TIME,abs(RV_EKFdata.error(:,1))/1000,'--k',TIME,abs(RV_SPUKFdata.error(:,1))/1000,':k',...
    TIME,abs(RV_ESPUKFdata.error(:,1))/1000,'-.k', TIME,abs(RV_UKFdata.error(:,1))/1000,'-k','LineWidth',1.5)
grid on
set(gca,'FontSize',15,'FontName','Times New Roman')
xlabel('Time (s)','FontSize',15,'FontName','Times New Roman')
ylabel({'Altitude'; 'error (km)'},'FontSize',15,'FontName','Times New Roman')
%legend('EKF','SPUKF','ESPUKF','UKF')
%legend boxoff

subplot(3,1,2)
plot(TIME,abs(RV_EKFdata.error(:,2))/1000,'--k',TIME,abs(RV_SPUKFdata.error(:,2))/1000,':k',...
    TIME,abs(RV_ESPUKFdata.error(:,2))/1000,'-.k', TIME,abs(RV_UKFdata.error(:,2))/1000,'-k','LineWidth',1.5)
grid on
set(gca,'FontSize',15,'FontName','Times New Roman')
xlabel('Time (s)','FontSize',15,'FontName','Times New Roman')
ylabel({'Down-range'; 'error (km)'},'FontSize',15,'FontName','Times New Roman')
% legend('EKF','SPUKF','ESPUKF','UKF')
% legend boxoff

subplot(3,1,3)
plot(TIME,abs(RV_EKFdata.error(:,3))/1000,'--k',TIME,abs(RV_SPUKFdata.error(:,3))/1000,':k',...
    TIME,abs(RV_ESPUKFdata.error(:,3))/1000,'-.k', TIME,abs(RV_UKFdata.error(:,3))/1000,'-k','LineWidth',1.5)
grid on
set(gca,'FontSize',15,'FontName','Times New Roman')
xlabel('Time (s)','FontSize',15,'FontName','Times New Roman')
ylabel({'Velocity'; 'error (km/s)'},'FontSize',15,'FontName','Times New Roman')
legend('EKF','SPUKF','ESPUKF','UKF')
legend boxoff

% subplot(2,2,4)
% plot(TIME,abs(rad2deg(RV_EKFdata.error(:,4))),'--k',TIME,abs(rad2deg(RV_SPUKFdata.error(:,4))),':k',...
%     TIME,abs(rad2deg(RV_ESPUKFdata.error(:,4))),'-.k', TIME,abs(rad2deg(RV_UKFdata.error(:,4))),'-k','LineWidth',1.5)
% set(gca,'FontSize',15,'FontName','Times New Roman')
% xlabel('Time (s)','FontSize',15,'FontName','Times New Roman')
% ylabel('Flight path angle (deg)','FontSize',15,'FontName','Times New Roman')
% legend('EKF','SPUKF','ESPUKF','UKF')
% legend boxoff

figure
subplot(3,1,1)
plot(TIME,abs(RV_SPUKFdata.error(:,1))/1000,':k',...
    TIME,abs(RV_ESPUKFdata.error(:,1))/1000,'-.k', TIME,abs(RV_UKFdata.error(:,1))/1000,'-k','LineWidth',1.5)
grid on
set(gca,'FontSize',15,'FontName','Times New Roman')
xlabel('Time (s)','FontSize',15,'FontName','Times New Roman')
ylabel({'Altitude'; 'error (km)'},'FontSize',15,'FontName','Times New Roman')
% legend('SPUKF','ESPUKF','UKF')
% legend boxoff

subplot(3,1,2)
plot(TIME,abs(RV_SPUKFdata.error(:,2))/1000,':k',...
    TIME,abs(RV_ESPUKFdata.error(:,2))/1000,'-.k', TIME,abs(RV_UKFdata.error(:,2))/1000,'-k','LineWidth',1.5)
grid on
set(gca,'FontSize',15,'FontName','Times New Roman')
xlabel('Time (s)','FontSize',15,'FontName','Times New Roman')
ylabel({'Down-range'; 'error (km)'},'FontSize',15,'FontName','Times New Roman')
% legend('EKF','SPUKF','ESPUKF','UKF')
% legend boxoff

subplot(3,1,3)
plot(TIME,abs(RV_SPUKFdata.error(:,3))/1000,':k',...
    TIME,abs(RV_ESPUKFdata.error(:,3))/1000,'-.k', TIME,abs(RV_UKFdata.error(:,3))/1000,'-k','LineWidth',1.5)
grid on
set(gca,'FontSize',15,'FontName','Times New Roman')
xlabel('Time (s)','FontSize',15,'FontName','Times New Roman')
ylabel({'Velocity'; 'error (km/s)'},'FontSize',15,'FontName','Times New Roman')
legend('SPUKF','ESPUKF','UKF')
legend boxoff
