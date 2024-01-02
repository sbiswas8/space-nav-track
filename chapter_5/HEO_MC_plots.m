clc
close all
clear all

load Run500_2
nor = 100;

prcsd_data = struct();
orbit_ecc = [0.1 0.4 0.7 0.9];
n_ecc = length(orbit_ecc);

for i = 1:nor
    [EKF, UKF, SPUKF, ESPUKF] = heo_analysis(Run(i).Estimate);
    
    for j = 1:n_ecc
        prcsd_data.EKF(j).rmser(i) =  EKF(j).rmser;
        prcsd_data.EKF(j).rmsev(i) =  EKF(j).rmsev;
        prcsd_data.EKF(j).extime(i) = EKF(j).ex_t;
        
        prcsd_data.UKF(j).rmser(i) =  UKF(j).rmser;
        prcsd_data.UKF(j).rmsev(i) =  UKF(j).rmsev;
        prcsd_data.UKF(j).extime(i) = UKF(j).ex_t;
        
        prcsd_data.SPUKF(j).rmser(i) =  SPUKF(j).rmser;
        prcsd_data.SPUKF(j).rmsev(i) =  SPUKF(j).rmsev;
        prcsd_data.SPUKF(j).extime(i) = SPUKF(j).ex_t;
        
        prcsd_data.ESPUKF(j).rmser(i) =  ESPUKF(j).rmser;
        prcsd_data.ESPUKF(j).rmsev(i) =  ESPUKF(j).rmsev;
        prcsd_data.ESPUKF(j).extime(i) = ESPUKF(j).ex_t;
    end
end

for i = 1:n_ecc
    prcsd_data.EKF(i).rmean = mean(prcsd_data.EKF(i).rmser);
    prcsd_data.EKF(i).rstd = std(prcsd_data.EKF(i).rmser);
    prcsd_data.EKF(i).vmean = mean(prcsd_data.EKF(i).rmsev);
    prcsd_data.EKF(i).vstd = std(prcsd_data.EKF(i).rmsev);
    prcsd_data.EKF(i).ext_mean = mean(prcsd_data.EKF(i).extime);
    prcsd_data.EKF(i).ext_std = std(prcsd_data.EKF(i).extime);
    
    prcsd_data.UKF(i).rmean = mean(prcsd_data.UKF(i).rmser);
    prcsd_data.UKF(i).rstd = std(prcsd_data.UKF(i).rmser);
    prcsd_data.UKF(i).vmean = mean(prcsd_data.UKF(i).rmsev);
    prcsd_data.UKF(i).vstd = std(prcsd_data.UKF(i).rmsev);
    prcsd_data.UKF(i).ext_mean = mean(prcsd_data.UKF(i).extime);
    prcsd_data.UKF(i).ext_std = std(prcsd_data.UKF(i).extime);
    
    prcsd_data.SPUKF(i).rmean = mean(prcsd_data.SPUKF(i).rmser);
    prcsd_data.SPUKF(i).rstd = std(prcsd_data.SPUKF(i).rmser);
    prcsd_data.SPUKF(i).vmean = mean(prcsd_data.SPUKF(i).rmsev);
    prcsd_data.SPUKF(i).vstd = std(prcsd_data.SPUKF(i).rmsev);
    prcsd_data.SPUKF(i).ext_mean = mean(prcsd_data.SPUKF(i).extime);
    prcsd_data.SPUKF(i).ext_std = std(prcsd_data.SPUKF(i).extime);
    
    prcsd_data.ESPUKF(i).rmean = mean(prcsd_data.ESPUKF(i).rmser);
    prcsd_data.ESPUKF(i).rstd = std(prcsd_data.ESPUKF(i).rmser);
    prcsd_data.ESPUKF(i).vmean = mean(prcsd_data.ESPUKF(i).rmsev);
    prcsd_data.ESPUKF(i).vstd = std(prcsd_data.ESPUKF(i).rmsev);
    prcsd_data.ESPUKF(i).ext_mean = mean(prcsd_data.ESPUKF(i).extime);
    prcsd_data.ESPUKF(i).ext_std = std(prcsd_data.ESPUKF(i).extime);
end

figure
subplot(2,2,1)
rms_plot(prcsd_data,1, nor)

subplot(2,2,2)
rms_plot(prcsd_data,2, nor)

subplot(2,2,3)
rms_plot(prcsd_data,3, nor)

subplot(2,2,4)
rms_plot(prcsd_data,4, nor)
legend('EKF', 'UKF', 'SPUKF', 'ESPUKF')
matlab2tikz('C:\Users\sanat\Google Drive\MyPapers\Conference\ICC\Tikz\MC_plots\rms_err_mc.tikz','floatFormat', '%0.3f')

figure
term_plot(prcsd_data, orbit_ecc, 'rmean')
ylabel('Mean RMS error (m)','FontSize',15,'FontName','Times New Roman')
legend('EKF', 'UKF', 'SPUKF', 'ESPUKF')
matlab2tikz('C:\Users\sanat\Google Drive\MyPapers\Conference\ICC\Tikz\MC_plots\rms_mean.tikz','floatFormat', '%0.3f')

figure
term_plot(prcsd_data, orbit_ecc, 'rstd')
ylabel('Mean Standard deviation in RMS error (m)','FontSize',15,'FontName','Times New Roman')
legend('EKF', 'UKF', 'SPUKF', 'ESPUKF')
matlab2tikz('C:\Users\sanat\Google Drive\MyPapers\Conference\ICC\Tikz\MC_plots\rms_std.tikz','floatFormat', '%0.3f')

figure
term_plot(prcsd_data, orbit_ecc, 'ext_mean')
ylabel('Mean processing time (s)','FontSize',15,'FontName','Times New Roman')
legend('EKF', 'UKF', 'SPUKF', 'ESPUKF')
matlab2tikz('C:\Users\sanat\Google Drive\MyPapers\Conference\ICC\Tikz\MC_plots\extime_mean.tikz','floatFormat', '%0.3f')

figure
term_plot(prcsd_data, orbit_ecc, 'ext_std')
ylabel('Standard Deviation in processing time (s)','FontSize',15,'FontName','Times New Roman')
legend('EKF', 'UKF', 'SPUKF', 'ESPUKF')
matlab2tikz('C:\Users\sanat\Google Drive\MyPapers\Conference\ICC\Tikz\MC_plots\extime_std.tikz','floatFormat', '%0.3f')

function rms_plot(data, ind, nor)
plot(1:nor,data.EKF(ind).rmser,'--k',1:nor,data.UKF(ind).rmser,'--r',...
    1:nor,data.SPUKF(ind).rmser,'--g', 1:nor,data.ESPUKF(ind).rmser,'--b','LineWidth',1.2)
set(gca,'FontSize',15,'FontName','Times New Roman')
xlabel('Exp. no','FontSize',15,'FontName','Times New Roman')
ylabel('RMS position error (m)','FontSize',15,'FontName','Times New Roman')
end

function term_plot(data, ecc, term)
n_ecc = length(ecc);
ekf = nan(1, n_ecc);
ukf = nan(1, n_ecc);
spukf = nan(1, n_ecc);
espukf = nan(1, n_ecc);
for i = 1:n_ecc
    ekf(i) = getfield(data.EKF(i), term);
    ukf(i) = getfield(data.UKF(i), term);
    spukf(i) = getfield(data.SPUKF(i), term);
    espukf(i) = getfield(data.ESPUKF(i), term);
end
plot(ecc, ekf, '--ok', ecc, ukf, '--<r', ecc, spukf, '--sg', ecc, espukf, '--xb','LineWidth',1.2)
set(gca,'FontSize',15,'FontName','Times New Roman')
xlabel('Orbit Ecc.','FontSize',15,'FontName','Times New Roman')
end