clear all
close all
load LV_MR_dataNS4
EKF_data.S4 = EKF_MR;
UKF_data.S4 = UKF_MR;
SPUKF_data.S4 = SPUKF_MR;
ESPUKF_data.S4 = ESPUKF_MR;

clear EKF_MR UKF_MR SPUKF_MR ESPUKF_MR;

load LV_MR_dataNS6
EKF_data.S6 = EKF_MR;
UKF_data.S6 = UKF_MR;
SPUKF_data.S6 = SPUKF_MR;
ESPUKF_data.S6 = ESPUKF_MR;

clear EKF_MR UKF_MR SPUKF_MR ESPUKF_MR;

load LV_MR_dataNS8
EKF_data.S8 = EKF_MR;
UKF_data.S8 = UKF_MR;
SPUKF_data.S8 = SPUKF_MR;
ESPUKF_data.S8 = ESPUKF_MR;

clear EKF_MR UKF_MR SPUKF_MR ESPUKF_MR;

load LV_MR_dataNS10
EKF_data.S10 = EKF_MR;
UKF_data.S10 = UKF_MR;
SPUKF_data.S10 = SPUKF_MR;
ESPUKF_data.S10 = ESPUKF_MR;

clear EKF_MR UKF_MR SPUKF_MR ESPUKF_MR;
%load KF_MR_all_data
load avPDOP.mat
avPDOP = avPDOP/20*100;
EKF_MR_med = [median(EKF_data.S4.MEAN); median(EKF_data.S6.MEAN);...
    median(EKF_data.S8.MEAN); median(EKF_data.S10.MEAN)];

UKF_MR_med = [median(UKF_data.S4.MEAN); median(UKF_data.S6.MEAN);...
    median(UKF_data.S8.MEAN); median(UKF_data.S10.MEAN)];

SPUKF_MR_med = [median(SPUKF_data.S4.MEAN); median(SPUKF_data.S6.MEAN);...
    median(SPUKF_data.S8.MEAN); median(SPUKF_data.S10.MEAN)];

ESPUKF_MR_med = [median(ESPUKF_data.S4.MEAN); median(ESPUKF_data.S6.MEAN);...
    median(ESPUKF_data.S8.MEAN); median(ESPUKF_data.S10.MEAN)];

% UKF_ER = EKF_MR_med./UKF_MR_med;
% SPUKF_ER = EKF_MR_med./SPUKF_MR_med;
% ESPUKF_ER = EKF_MR_med./ESPUKF_MR_med;
nos = [4 6 8 10];

EKF_Pmed = [median(sqrt(EKF_data.S4.MEAN(:,1).^2 + EKF_data.S4.MEAN(:,2).^2)) median(sqrt(EKF_data.S6.MEAN(:,1).^2 + EKF_data.S6.MEAN(:,2).^2))...
    median(sqrt(EKF_data.S8.MEAN(:,1).^2 + EKF_data.S8.MEAN(:,2).^2)) median(sqrt(EKF_data.S10.MEAN(:,1).^2 + EKF_data.S10.MEAN(:,2).^2))];
UKF_Pmed = [median(sqrt(UKF_data.S4.MEAN(:,1).^2 + UKF_data.S4.MEAN(:,2).^2)) median(sqrt(UKF_data.S6.MEAN(:,1).^2 + UKF_data.S6.MEAN(:,2).^2))...
    median(sqrt(UKF_data.S8.MEAN(:,1).^2 + UKF_data.S8.MEAN(:,2).^2)) median(sqrt(UKF_data.S10.MEAN(:,1).^2 + UKF_data.S10.MEAN(:,2).^2))];
ESPUKF_Pmed = [median(sqrt(ESPUKF_data.S4.MEAN(:,1).^2 + ESPUKF_data.S4.MEAN(:,2).^2)) median(sqrt(ESPUKF_data.S6.MEAN(:,1).^2 + ESPUKF_data.S6.MEAN(:,2).^2))...
    median(sqrt(ESPUKF_data.S8.MEAN(:,1).^2 + ESPUKF_data.S8.MEAN(:,2).^2)) median(sqrt(ESPUKF_data.S10.MEAN(:,1).^2 + ESPUKF_data.S10.MEAN(:,2).^2))];
SPUKF_Pmed = [median(sqrt(SPUKF_data.S4.MEAN(:,1).^2 + SPUKF_data.S4.MEAN(:,2).^2)) median(sqrt(SPUKF_data.S6.MEAN(:,1).^2 + SPUKF_data.S6.MEAN(:,2).^2))...
    median(sqrt(SPUKF_data.S8.MEAN(:,1).^2 + SPUKF_data.S8.MEAN(:,2).^2)) median(sqrt(SPUKF_data.S10.MEAN(:,1).^2 + SPUKF_data.S10.MEAN(:,2).^2))];
% EKF_PER = avPDOP./EKF_Pmed;
% UKF_PER = avPDOP./UKF_Pmed;
% SPUKF_PER = avPDOP./SPUKF_Pmed;
% ESPUKF_PER = avPDOP./ESPUKF_Pmed;

EKF_PER = EKF_Pmed./avPDOP;
UKF_PER = UKF_Pmed./avPDOP;
SPUKF_PER = SPUKF_Pmed./avPDOP;
ESPUKF_PER = ESPUKF_Pmed./avPDOP;

EKF_T = [mean(EKF_data.S4.ExTime) mean(EKF_data.S6.ExTime) mean(EKF_data.S8.ExTime) mean(EKF_data.S10.ExTime)];
UKF_T = [mean(UKF_data.S4.ExTime) mean(UKF_data.S6.ExTime) mean(UKF_data.S8.ExTime) mean(UKF_data.S10.ExTime)];
ESPUKF_T = [mean(ESPUKF_data.S4.ExTime) mean(ESPUKF_data.S6.ExTime) mean(ESPUKF_data.S8.ExTime) mean(ESPUKF_data.S10.ExTime)];
SPUKF_T = [mean(SPUKF_data.S4.ExTime) mean(SPUKF_data.S6.ExTime) mean(SPUKF_data.S8.ExTime) mean(SPUKF_data.S10.ExTime)];
exTime = [EKF_T;SPUKF_T;ESPUKF_T;UKF_T]*1000;
P_err = [EKF_Pmed;SPUKF_Pmed;ESPUKF_Pmed;UKF_Pmed];


% subplot(2,1,2)
% plot(nos,UKF_ER(:,3),'-ok',nos,ESPUKF_ER(:,3),'-.ok',nos,SPUKF_ER(:,3),':ok')
% xlabel('No. of satellites')
% ylabel('Velocity error ratio')

figure
stairs(exTime(:,1),P_err(:,1),'-ob','LineWidth',1.2)
hold on
stairs(exTime(:,2),P_err(:,2),'-og','LineWidth',1.2)
stairs(exTime(:,3),P_err(:,3),'-or','LineWidth',1.2)
stairs(exTime(:,4),P_err(:,4),'-ok','LineWidth',1.2)
set(gca,'FontSize',17,'FontName','San serif')
xlim([0 65])
ylim([5 45])
xlabel('Processing time (ms)','FontSize',17,'FontName','San serif')
ylabel('Average position error (m)','FontSize',17,'FontName','San serif')
legend('S4','S6','S8','S10')

[x1,y1] = ds2nfu(exTime(1,1),P_err(1,1));
[x2,y2] = ds2nfu(17,40);
annotation('textarrow',[x2,x1],[y2,y1],...
           'String','EKF','FontSize',17,'FontName','San serif')
[x1,y1] = ds2nfu(exTime(2,1),P_err(2,1));
[x2,y2] = ds2nfu(20,25);
annotation('textarrow',[x2,x1],[y2,y1],...
           'String','SPUKF(new)','FontSize',17,'FontName','San serif')

[x1,y1] = ds2nfu(exTime(3,1),P_err(3,1));
[x2,y2] = ds2nfu(25,20);
annotation('textarrow',[x2,x1],[y2,y1],...
           'String','ESPUKF(new)','FontSize',17,'FontName','San serif')

[x1,y1] = ds2nfu(exTime(4,1),P_err(4,1));
[x2,y2] = ds2nfu(55,P_err(4,1));
annotation('textarrow',[x2,x1],[y2,y1],...
           'String','UKF','FontSize',17,'FontName','San serif')
   
       
       
[x1,y1] = ds2nfu(exTime(1,2),P_err(1,2));
[x2,y2] = ds2nfu(15,40);
annotation('textarrow',[x2,x1],[y2,y1])

[x1,y1] = ds2nfu(exTime(2,2),P_err(2,2));
[x2,y2] = ds2nfu(20,25);
annotation('textarrow',[x2,x1],[y2,y1])

[x1,y1] = ds2nfu(exTime(3,2),P_err(3,2));
[x2,y2] = ds2nfu(25,20);
annotation('textarrow',[x2,x1],[y2,y1])

[x1,y1] = ds2nfu(exTime(4,2),P_err(4,2));
[x2,y2] = ds2nfu(55,P_err(4,1));
annotation('textarrow',[x2,x1],[y2,y1])


[x1,y1] = ds2nfu(exTime(1,3),P_err(1,3));
[x2,y2] = ds2nfu(15,40);
annotation('textarrow',[x2,x1],[y2,y1])

[x1,y1] = ds2nfu(exTime(2,3),P_err(2,3));
[x2,y2] = ds2nfu(20,25);
annotation('textarrow',[x2,x1],[y2,y1])

[x1,y1] = ds2nfu(exTime(3,3),P_err(3,3));
[x2,y2] = ds2nfu(25,20);
annotation('textarrow',[x2,x1],[y2,y1])

[x1,y1] = ds2nfu(exTime(4,3),P_err(4,3));
[x2,y2] = ds2nfu(55,P_err(4,1));
annotation('textarrow',[x2,x1],[y2,y1])


[x1,y1] = ds2nfu(exTime(1,4),P_err(1,4));
[x2,y2] = ds2nfu(15,40);
annotation('textarrow',[x2,x1],[y2,y1])

[x1,y1] = ds2nfu(exTime(2,4),P_err(2,4));
[x2,y2] = ds2nfu(20,25);
annotation('textarrow',[x2,x1],[y2,y1])

[x1,y1] = ds2nfu(exTime(3,4),P_err(3,4));
[x2,y2] = ds2nfu(25,20);
annotation('textarrow',[x2,x1],[y2,y1])

[x1,y1] = ds2nfu(exTime(4,4),P_err(4,4));
[x2,y2] = ds2nfu(55,P_err(4,1));
annotation('textarrow',[x2,x1],[y2,y1])
print('LV_KF_PT','-depsc','-tiff')

figure
%subplot(2,1,1)
plot(nos,UKF_PER,'-ok',nos,ESPUKF_PER,'-or',nos,SPUKF_PER,'-og',nos,EKF_PER,'-ob','LineWidth',1.5)
set(gca,'FontSize',20,'FontName','Times New Roman')
grid on
xlabel('No. of satellites','FontSize',20,'FontName','Times New Roman')
ylabel('error/(PDOP\sigma_R)','FontSize',20,'FontName','Times New Roman')
legend('UKF','ESPUKF','SPUKF','EKF')
legend boxoff
print('NoS_vs_er','-depsc','-tiff')

figure
%subplot(2,1,2)
plot(nos,EKF_Pmed,'--k',nos,SPUKF_Pmed,':k',nos,ESPUKF_Pmed,'-.k',nos,UKF_Pmed,'k','LineWidth',1.5)
set(gca,'FontSize',15,'FontName','Times New Roman')
xlabel('No. of satellites','FontSize',15,'FontName','Times New Roman')
ylabel('Position error (m)','FontSize',15,'FontName','Times New Roman')
legend('EKF','SPUKF','ESPUKF','UKF')
legend boxoff

figure
%subplot(2,1,1)
plot(nos,avPDOP/100,'-ok','LineWidth',1.5)
grid on
set(gca,'FontSize',15,'FontName','Times New Roman')
xlabel('No. of satellites','FontSize',15,'FontName','Times New Roman')
ylabel('PDOP','FontSize',15,'FontName','Times New Roman')

%%
x = avPDOP/100;
xq = x(end):0.01:x(1);
y_ekf = (EKF_Pmed/100).^2;
y_spukf = (SPUKF_Pmed/100).^2;
y_espukf = (ESPUKF_Pmed/100).^2;
y_ukf = (UKF_Pmed/100).^2;
F_ekf = interp1(x,y_ekf,xq,'spline');
F_spukf = interp1(x,y_spukf,xq,'spline');
F_espukf = interp1(x,y_espukf,xq,'spline');
F_ukf = interp1(x,y_ukf,xq,'spline');
%%

figure
%subplot(2,1,2)
% plot(xq,F_ekf,'--k',xq,F_spukf,':k',xq,F_espukf,'-.k',xq,F_ukf,'-k',x,y_ekf,'ok',x,y_spukf,'ok',...
%     x,y_espukf,'ok',x,y_ukf,'ok','LineWidth',1.5)
plot(x,y_ekf,'--ok',x,y_spukf,':ok',x,y_espukf,'-.ok',x,y_ukf,'-ok','LineWidth',1.5)
grid on
set(gca,'FontSize',15,'FontName','Times New Roman')
xlabel('PDOP','FontSize',15,'FontName','Times New Roman')
ylabel('(Position error/\sigma_R)^2','FontSize',15,'FontName','Times New Roman')
legend('EKF','SPUKF','ESPUKF','UKF')
legend boxoff
