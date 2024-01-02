clear all
load LV_MR_dataNS4
k = 1:200;
figure
subplot(4,1,1)
plot(k,EKF_MR.MEAN(:,1),'b',k,SPUKF_MR.MEAN(:,1),'g',k,ESPUKF_MR.MEAN(:,1),'r',k,UKF_MR.MEAN(:,1),'k','LineWidth',1.5)
set(gca,'FontSize',15,'FontName','Times New Roman')
grid on
ylim([0 25])
%xlabel('No. of run','FontSize',15,'FontName','Times New Roman')
ylabel({'Down-range'; 'error (m)'},'FontSize',15,'FontName','Times New Roman')
subplot(4,1,2)
plot(k,EKF_MR.MEAN(:,2),'b',k,SPUKF_MR.MEAN(:,2),'g',k,ESPUKF_MR.MEAN(:,2),'r',k,UKF_MR.MEAN(:,2),'k','LineWidth',1.5)
set(gca,'FontSize',15,'FontName','Times New Roman')
grid on
ylim([0 80])
%xlabel('No. of run','FontSize',15,'FontName','Times New Roman')
ylabel({'Altitude'; 'error (m)'},'FontSize',15,'FontName','Times New Roman')

subplot(4,1,3)
plot(k,EKF_MR.MEAN(:,3),'b',k,SPUKF_MR.MEAN(:,3),'g',k,ESPUKF_MR.MEAN(:,3),'r',k,UKF_MR.MEAN(:,3),'k','LineWidth',1.5)
set(gca,'FontSize',15,'FontName','Times New Roman')
grid on
ylim([0 1.5])
%xlabel('No. of run','FontSize',15,'FontName','Times New Roman')
ylabel({'Velocity'; 'error (m/s)'},'FontSize',15,'FontName','Times New Roman')

subplot(4,1,4)
plot(k,EKF_MR.ExTime*1000,'b',k,SPUKF_MR.ExTime*1000,'g',k,ESPUKF_MR.ExTime*1000,'r',k,UKF_MR.ExTime*1000,'k','LineWidth',1.5)
set(gca,'FontSize',15,'FontName','Times New Roman')
grid on
%ylim([0 .08])
xlabel('No. of run','FontSize',15,'FontName','Times New Roman')
ylabel({'Processing'; 'time (ms)'},'FontSize',15,'FontName','Times New Roman')
legend('EKF','SPUKF','ESPUKF','UKF')
%print('KF_MC_NS10','-depsc','-tiff')
%legend boxoff