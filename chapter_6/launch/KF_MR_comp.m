clear all
load LV_MR_dataNS10
NoR = 50;
k = 1:NoR;
figure
subplot(3,1,1)
plot(k,EKF_MR.MEAN(1:NoR,1),'--k',k,SPUKF_MR.MEAN(1:NoR,1),':k',k,ESPUKF_MR.MEAN(1:NoR,1),'-.k',k,UKF_MR.MEAN(1:NoR,1),'k', 'LineWidth', 1.5)
set(gca,'FontSize',17,'FontName','Times New Roman')
grid on
ylim([0 25])
%xlabel('No. of run','FontSize',17,'FontName','Times New Roman')
ylabel({'Down-range'; 'error (m)'},'FontSize',17,'FontName','Times New Roman')
subplot(3,1,2)
plot(k,EKF_MR.MEAN(1:NoR,2),'--k',k,SPUKF_MR.MEAN(1:NoR,2),':k',k,ESPUKF_MR.MEAN(1:NoR,2),'-.k',k,UKF_MR.MEAN(1:NoR,2),'k', 'LineWidth', 1.5)
set(gca,'FontSize',17,'FontName','Times New Roman')
grid on
ylim([0 80])
%xlabel('No. of run','FontSize',17,'FontName','Times New Roman')
ylabel({'Altitude'; 'error (m)'},'FontSize',17,'FontName','Times New Roman')

subplot(3,1,3)
plot(k,EKF_MR.MEAN(1:NoR,3),'--k',k,SPUKF_MR.MEAN(1:NoR,3),':k',k,ESPUKF_MR.MEAN(1:NoR,3),'-.k',k,UKF_MR.MEAN(1:NoR,3),'k', 'LineWidth', 1.5)
set(gca,'FontSize',17,'FontName','Times New Roman')
grid on
ylim([0 1.5])
%xlabel('No. of run','FontSize',17,'FontName','Times New Roman')
ylabel({'Velocity'; 'error (m/s)'},'FontSize',17,'FontName','Times New Roman')

% subplot(4,1,4)
% plot(k,EKF_MR.ExTime(1:NoR)*1000,'--k',k,SPUKF_MR.ExTime(1:NoR)*1000,':k',k,ESPUKF_MR.ExTime(1:NoR)*1000,'-.k',k,UKF_MR.ExTime(1:NoR)*1000,'k', 'LineWidth', 1.5)
% set(gca,'FontSize',17,'FontName','Times New Roman')
% grid on
% %ylim([0 .08])
xlabel('No. of run','FontSize',17,'FontName','Times New Roman')
% ylabel({'Processing'; 'time (ms)'},'FontSize',17,'FontName','Times New Roman')
legend('EKF','SPUKF','ESPUKF','UKF')
%print('KF_MC_NS10','-depsc','-tiff')
legend boxoff
matlab2tikz(strcat('lv_kfs_mc.tikz'),'floatFormat', '%0.3f')