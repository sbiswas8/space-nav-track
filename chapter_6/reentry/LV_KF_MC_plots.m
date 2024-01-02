clc
clear all
close all
load RV_KF_MCdata
NoR = 50;

for i = 1:NoR
    ekf_mean(i,:) = mean(abs(EKF_MC(i).Mean_error),1);
    ukf_mean(i,:) = mean(abs(UKF_MC(i).Mean_error),1);
    spukf_mean(i,:) = mean(abs(SPUKF_MC(i).Mean_error),1);
    espukf_mean(i,:) = mean(abs(ESPUKF_MC(i).Mean_error),1);
    
    ekf_std(i,:) = mean(abs(EKF_MC(i).Mean_std),1);
    ukf_std(i,:) = mean(abs(UKF_MC(i).Mean_std),1);
    spukf_std(i,:) = mean(abs(SPUKF_MC(i).Mean_std),1);
    espukf_std(i,:) = mean(abs(ESPUKF_MC(i).Mean_std),1);
end
expn = 1:NoR;
figure
subplot(3,1,1)
plot(expn, ukf_mean(:,1)/1000, 'k', expn, spukf_mean(:,1)/1000, ':k', expn, espukf_mean(:,1)/1000, '-.k', 'LineWidth',1.5)
set(gca,'FontSize',15,'FontName','Times New Roman')
xlabel('No. of runs','FontSize',15,'FontName','Times New Roman')
ylabel({'Altitude'; 'error (km)'},'FontSize',15,'FontName','Times New Roman')

subplot(3,1,2)
plot(expn, ukf_mean(:,2)/1000, 'k',expn, spukf_mean(:,2)/1000, ':k', expn, espukf_mean(:,2)/1000, '-.k', 'LineWidth',1.5)
set(gca,'FontSize',15,'FontName','Times New Roman')
xlabel('No. of runs','FontSize',15,'FontName','Times New Roman')
ylabel({'Down-range'; 'error (km)'},'FontSize',15,'FontName','Times New Roman')

subplot(3,1,3)
plot(expn, ukf_mean(:,3)/1000, 'k', expn, spukf_mean(:,3)/1000, ':k', expn, espukf_mean(:,3)/1000, '-.k', 'LineWidth',1.5)
set(gca,'FontSize',15,'FontName','Times New Roman')
xlabel('No. of runs','FontSize',15,'FontName','Times New Roman')
ylabel({'Velocity'; 'error (km/s)'},'FontSize',15,'FontName','Times New Roman')
legend('UKF', 'SPUKF','ESPUKF')
legend boxoff
matlab2tikz(strcat('rv_ukfs_mc.tikz'),'floatFormat', '%0.3f')

figure
subplot(3,1,1)
plot(expn, ekf_mean(:,1)/1000, 'k', 'LineWidth',1.5)
set(gca,'FontSize',15,'FontName','Times New Roman')
xlabel('No. of runs','FontSize',15,'FontName','Times New Roman')
ylabel({'Altitude'; 'error (km)'},'FontSize',15,'FontName','Times New Roman')

subplot(3,1,2)
plot(expn, ekf_mean(:,2)/1000, 'k', 'LineWidth',1.5)
set(gca,'FontSize',15,'FontName','Times New Roman')
xlabel('No. of runs','FontSize',15,'FontName','Times New Roman')
ylabel({'Down-range'; 'error (km)'},'FontSize',15,'FontName','Times New Roman')

subplot(3,1,3)
plot(expn, ekf_mean(:,2)/1000, 'k', 'LineWidth',1.5)
set(gca,'FontSize',15,'FontName','Times New Roman')
xlabel('No. of runs','FontSize',15,'FontName','Times New Roman')
ylabel({'Velocity'; 'error (km/s)'},'FontSize',15,'FontName','Times New Roman')
%matlab2tikz(strcat('rv_ekf_mc.tikz'),'floatFormat', '%0.3f')
