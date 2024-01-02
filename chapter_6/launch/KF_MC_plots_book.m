clc
clear all
close all
% load EKF_MC
% load UKF_MC
% load SPUKF_MC
% load ESPUKF_MC
load MC_data_book_R2
load EKF_MC_R3
NoR = 20;
EKF_MC = EKF_MC(2:end);
t_end = length(UKF_MC(2).Mean_error);
EKF_mean_error = zeros(t_end, 3);
SPUKF_mean_error = zeros(t_end, 3);
ESPUKF_mean_error = zeros(t_end, 3);
UKF_mean_error = zeros(t_end, 3);

EKF_mean_std = zeros(t_end, 3);
SPUKF_mean_std = zeros(t_end, 3);
ESPUKF_mean_std = zeros(t_end, 3);
UKF_mean_std = zeros(t_end, 3);

for i = 1:t_end
    for j = 1:NoR
        EKF_mean_error(i,:) = EKF_mean_error(i,:) + EKF_MC(j).Mean_error(i,1:3);
        SPUKF_mean_error(i,:) = SPUKF_mean_error(i,:) + SPUKF_MC(j).Mean_error(i,1:3);
        ESPUKF_mean_error(i,:) = ESPUKF_mean_error(i,:) + ESPUKF_MC(j).Mean_error(i,1:3);
        UKF_mean_error(i,:) = UKF_mean_error(i,:) + UKF_MC(j).Mean_error(i,1:3);
        
        EKF_mean_std(i,:) = EKF_mean_std(i,:) + EKF_MC(j).Mean_std(i,1:3);
        SPUKF_mean_std(i,:) = SPUKF_mean_std(i,:) + SPUKF_MC(j).Mean_std(i,1:3);
        ESPUKF_mean_std(i,:) = ESPUKF_mean_std(i,:) + ESPUKF_MC(j).Mean_std(i,1:3);
        UKF_mean_std(i,:) = UKF_mean_std(i,:) + UKF_MC(j).Mean_std(i,1:3);
    end
    EKF_mean_error(i,:) = EKF_mean_error(i,:)/NoR;
    SPUKF_mean_error(i,:) = SPUKF_mean_error(i,:)/NoR;
    ESPUKF_mean_error(i,:) = ESPUKF_mean_error(i,:)/NoR;
    UKF_mean_error(i,:) = UKF_mean_error(i,:)/NoR;
    
    EKF_mean_std(i,:) = EKF_mean_std(i,:)/NoR;
    SPUKF_mean_std(i,:) = SPUKF_mean_std(i,:)/NoR;
    ESPUKF_mean_std(i,:) = ESPUKF_mean_std(i,:)/NoR;
    UKF_mean_std(i,:) = UKF_mean_std(i,:)/NoR;
end
% Stats
EKF_MC_mean_error = mean(abs(EKF_mean_error(100:end)),1);
UKF_MC_mean_error = mean(abs(UKF_mean_error(100:end)),1);
SPUKF_MC_mean_error = mean(abs(SPUKF_mean_error(100:end)),1);
ESPUKF_MC_mean_error = mean(abs(ESPUKF_mean_error(100:end)),1);

EKF_MC_mean_std = mean(EKF_mean_std,1);
UKF_MC_mean_std = mean(UKF_mean_std,1);
SPUKF_MC_mean_std = mean(SPUKF_mean_std,1);
ESPUKF_MC_mean_std = mean(ESPUKF_mean_std,1);

% Table
fileID = fopen('LV_KF_stats.txt','w');
fprintf(fileID, 'Mean, Standard deviation,Mean, Standard deviation,Mean, Standard deviation\n');
fprintf(fileID, 'EKF, %0.3f, %0.3f, %0.3f, %0.3f, %0.3f, %0.3f\n',...
    EKF_MC_mean_error(1), EKF_MC_mean_std(1), EKF_MC_mean_error(2), EKF_MC_mean_std(2), EKF_MC_mean_error(3), EKF_MC_mean_std(3));
fprintf(fileID, 'SPUKF, %0.3f, %0.3f, %0.3f, %0.3f, %0.3f, %0.3f\n',...
    SPUKF_MC_mean_error(1), SPUKF_MC_mean_std(1), SPUKF_MC_mean_error(2), SPUKF_MC_mean_std(2), SPUKF_MC_mean_error(3), SPUKF_MC_mean_std(3));
fprintf(fileID, 'ESPUKF, %0.3f, %0.3f, %0.3f, %0.3f, %0.3f, %0.3f\n',...
    ESPUKF_MC_mean_error(1), ESPUKF_MC_mean_std(1), ESPUKF_MC_mean_error(2), ESPUKF_MC_mean_std(2), ESPUKF_MC_mean_error(3), ESPUKF_MC_mean_std(3));
fprintf(fileID, 'UKF, %0.3f, %0.3f, %0.3f, %0.3f, %0.3f, %0.3f\n',...
    UKF_MC_mean_error(1), UKF_MC_mean_std(1), UKF_MC_mean_error(2), UKF_MC_mean_std(2), UKF_MC_mean_error(3), UKF_MC_mean_std(3));
fclose(fileID);
time = 0:t_end-1;

figure
t1 = tiledlayout(3,1,'TileSpacing','Compact','Padding','Compact');
nexttile
plot(time, abs(SPUKF_mean_error(:,1)),':k',...
    time, abs(ESPUKF_mean_error(:,1)),'-.k',...
    time, abs(UKF_mean_error(:,1)),'k',...
    time, abs(SPUKF_mean_std(:,1)),':b',...
    time, abs(ESPUKF_mean_std(:,1)),'-.b',...
    time, abs(UKF_mean_std(:,1)),'b',...
    'LineWidth', 1.5)
set(gca,'FontSize',15,'FontName','Times New Roman')
xlabel('Time (s)','FontSize',15,'FontName','Times New Roman')
ylabel({'Down-range'; 'error (m)'},'FontSize',15,'FontName','Times New Roman')
legend('SPUKF', 'ESPUKF', 'UKF','\sigma-SPUKF', '\sigma-ESPUKF', '\sigma-UKF','NumColumns',1, 'Location','northeastoutside')
legend boxoff

nexttile
plot(time, abs(SPUKF_mean_error(:,2)),':k',...
    time, abs(ESPUKF_mean_error(:,2)),'-.k',...
    time, abs(UKF_mean_error(:,2)),'k',...
    time, abs(SPUKF_mean_std(:,2)),':b',...
    time, abs(ESPUKF_mean_std(:,2)),'-.b',...
    time, abs(UKF_mean_std(:,2)),'.-b',...
    'LineWidth', 1.5)
set(gca,'FontSize',15,'FontName','Times New Roman')
xlabel('Time (s)','FontSize',15,'FontName','Times New Roman')
ylabel({'Altitude'; 'error (m)'},'FontSize',15,'FontName','Times New Roman')

nexttile
plot(time, abs(SPUKF_mean_error(:,3)),':k',...
    time, abs(ESPUKF_mean_error(:,3)),'-.k',...
    time, abs(UKF_mean_error(:,3)),'k',...
    time, abs(SPUKF_mean_std(:,3)),':b',...
    time, abs(ESPUKF_mean_std(:,3)),'-.b',...
    time, abs(UKF_mean_std(:,3)),'b',...
    'LineWidth', 1.5)
set(gca,'FontSize',15,'FontName','Times New Roman')
xlabel('Time (s)','FontSize',15,'FontName','Times New Roman')
ylabel({'Velocity'; 'error (m/s)'},'FontSize',15,'FontName','Times New Roman')

%% zoomed plots
% ax1  = axes('position',[.35 .84 .25 .08]);
% box on
% plot(time, abs(SPUKF_mean_error(:,1)),':k', time, abs(ESPUKF_mean_error(:,1)),'-.k', time, abs(UKF_mean_error(:,1)),'k',...
%     time, abs(SPUKF_mean_std(:,1)),':b', time, abs(ESPUKF_mean_std(:,1)),'-.b', time, abs(UKF_mean_std(:,1)),'b', 'LineWidth', 1.5)
% set(gca,'FontSize',7,'FontName','Times New Roman')
% xlabel('Time (s)','FontSize',7,'FontName','Times New Roman')
% ylabel({'Down-range'; 'error (m)'},'FontSize',7,'FontName','Times New Roman')

ax2 = axes('position',[.4 .54 .25 .08]);
box on
plot(time, abs(SPUKF_mean_error(:,2)),':k',...
    time, abs(ESPUKF_mean_error(:,2)),'-.k',...
    time, abs(UKF_mean_error(:,2)),'k',...
    time, abs(SPUKF_mean_std(:,2)),':b',...
    time, abs(ESPUKF_mean_std(:,2)),'-.b',...
    time, abs(UKF_mean_std(:,2)),'b',...
    'LineWidth', 1.5)
ylim([0, 20])
set(gca,'FontSize',7,'FontName','Times New Roman')
xlabel('Time (s)','FontSize',7,'FontName','Times New Roman')
ylabel({'Altitude'; 'error (m)'},'FontSize',7,'FontName','Times New Roman')

ax3 = axes('position',[.4 .20 .25 .08]);
box on
plot(time, abs(SPUKF_mean_error(:,3)),':k',...
    time, abs(ESPUKF_mean_error(:,3)),'-.k',...
    time, abs(UKF_mean_error(:,3)),'k',...
    time, abs(SPUKF_mean_std(:,3)),':b',...
    time, abs(ESPUKF_mean_std(:,3)),'-.b',...
    time, abs(UKF_mean_std(:,3)),'b',...
    'LineWidth', 1.5)
ylim([0, 0.5])
set(gca,'FontSize',7,'FontName','Times New Roman')
xlabel('Time (s)','FontSize',7,'FontName','Times New Roman')
ylabel({'Velocity'; 'error (m/s)'},'FontSize',7,'FontName','Times New Roman')
t_zoom = gcf;
exportgraphics(t_zoom,'G:\My Drive\My_books\Simulations\LV_GPS_LOWOBS\KF_MC_LV.pdf','ContentType','vector')

figure
t2 = tiledlayout(3,1,'TileSpacing','Compact','Padding','Compact');
nexttile
plot(time, abs(EKF_mean_error(:,1)),'k', time, abs(EKF_mean_std(:,1)),'b', 'LineWidth', 1.5)
%ylim([0 1000])
set(gca,'FontSize',15,'FontName','Times New Roman')
xlabel('Time (s)','FontSize',15,'FontName','Times New Roman')
ylabel({'Down-range'; 'error (m)'},'FontSize',15,'FontName','Times New Roman')
legend('EKF error', '\sigma-EKF', 'NumColumns',1, 'Location','northeastoutside')
legend boxoff

nexttile
plot(time, abs(EKF_mean_error(:,2)),'k', time, abs(EKF_mean_std(:,2)),'b', 'LineWidth', 1.5)
%ylim([0 1000])
set(gca,'FontSize',15,'FontName','Times New Roman')
xlabel('Time (s)','FontSize',15,'FontName','Times New Roman')
ylabel({'Altitude'; 'error (m)'},'FontSize',15,'FontName','Times New Roman')

nexttile
plot(time, abs(EKF_mean_error(:,3)),'k', time, abs(EKF_mean_std(:,3)),'b', 'LineWidth', 1.5)
%ylim([0 1000])
set(gca,'FontSize',15,'FontName','Times New Roman')
xlabel('Time (s)','FontSize',15,'FontName','Times New Roman')
ylabel({'Velocity'; 'error (m/s)'},'FontSize',15,'FontName','Times New Roman')
exportgraphics(t2,'G:\My Drive\My_books\Simulations\LV_GPS_LOWOBS\EKF_MC_LV.pdf','ContentType','vector')