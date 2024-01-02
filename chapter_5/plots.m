%% Plots
clc
close all
clear all

load Estimate_2
Time  = 500;
e = [0.1 0.4 0.7 0.9];

for i = 1:4
    [error_t,error_av] = error_process(Estimate(i),Time);
    EKFPav(i) = error_av.EKF_avP;
    UKFPav(i) = error_av.UKF_avP;
    SPUKFPav(i)= error_av.SPUKF_avP;
    ESPUKFPav(i) = error_av.ESPUKF_avP;
    
    EKFVav(i) = error_av.EKF_avV;
    UKFVav(i) = error_av.UKF_avV;
    SPUKFVav(i)= error_av.SPUKF_avV;
    ESPUKFVav(i) = error_av.ESPUKF_avV;
    
    KFcomplot_PV(error_t,Time,e(i));
end

figure
plot(e,EKFPav,'--ok',e,UKFPav,'--sb',e,SPUKFPav,'--dr',e,ESPUKFPav,'--^m','LineWidth',1.2)
set(gca,'FontSize',10,'FontName','Times New Roman')
xlabel('Orbit eccentricity','FontSize',10,'FontName','Times New Roman')
ylabel('Average Position error (m)','FontSize',10,'FontName','Times New Roman')
legend('EKF','UKF','SPUKF','ESPUKF')

figure
plot(e,EKFVav,'--ok',e,UKFVav,'--sb',e,SPUKFVav,'--dr',e,ESPUKFVav,'--^m','LineWidth',1.2)
set(gca,'FontSize',10,'FontName','Times New Roman')
xlabel('Orbit eccentricity','FontSize',10,'FontName','Times New Roman')
ylabel('Average Velocity error (m/s)','FontSize',10,'FontName','Times New Roman')
legend('EKF','UKF','SPUKF','ESPUKF')
