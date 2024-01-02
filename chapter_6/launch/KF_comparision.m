clc
clear all
load LV_EKF_data.mat
load LV_SPUKF_data.mat
load LV_ESPUKF_data.mat
load LV_UKF_data.mat

EKF_MEAN = [rms(LV_EKF_data.error(200:end,1)) rms(LV_EKF_data.error(200:end,2)) rms(LV_EKF_data.error(200:end,3)) rms(LV_EKF_data.error(200:end,7))];
SPUKF_MEAN = [rms(LV_SPUKF_data.error(200:end,1)) rms(LV_SPUKF_data.error(200:end,2)) rms(LV_SPUKF_data.error(200:end,3)) rms(LV_SPUKF_data.error(200:end,7))];
ESPUKF_MEAN = [rms(LV_ESPUKF_data.error(200:end,1)) rms(LV_ESPUKF_data.error(200:end,2)) rms(LV_ESPUKF_data.error(200:end,3)) rms(LV_ESPUKF_data.error(200:end,7))];
UKF_MEAN = [rms(LV_UKF_data.error(200:end,1)) rms(LV_UKF_data.error(200:end,2)) rms(LV_UKF_data.error(200:end,3)) rms(LV_UKF_data.error(200:end,7))];
figure
subplot(2,2,1)
plot(LV_EKF_data.TIME,abs(LV_EKF_data.error(:,1)),'--k',LV_SPUKF_data.TIME,abs(LV_SPUKF_data.error(:,1)),':k',LV_ESPUKF_data.TIME,...
    abs(LV_ESPUKF_data.error(:,1)),'-.k',LV_UKF_data.TIME,abs(LV_UKF_data.error(:,1)),'k')
grid on
xlabel('Time (s)')
ylabel('Down-range Error (m)')

subplot(2,2,2)
plot(LV_EKF_data.TIME,abs(LV_EKF_data.error(:,2)),'--k',LV_SPUKF_data.TIME,abs(LV_SPUKF_data.error(:,2)),':k',LV_ESPUKF_data.TIME,...
    abs(LV_ESPUKF_data.error(:,2)),'-.k',LV_UKF_data.TIME,abs(LV_UKF_data.error(:,2)),'k')
grid on
xlabel('Time (s)')
ylabel('Altitude Error (m)')

subplot(2,2,3)
plot(LV_EKF_data.TIME,abs(LV_EKF_data.error(:,3)),'--k',LV_SPUKF_data.TIME,abs(LV_SPUKF_data.error(:,3)),':k',LV_ESPUKF_data.TIME,...
    abs(LV_ESPUKF_data.error(:,3)),'-.k',LV_UKF_data.TIME,abs(LV_UKF_data.error(:,3)),'k')
grid on
xlabel('Time (s)')
ylabel('Velocity Error (m)')

subplot(2,2,4)
plot(LV_EKF_data.TIME,abs(LV_EKF_data.error(:,7)),'--k',LV_SPUKF_data.TIME,abs(LV_SPUKF_data.error(:,7)),':k',LV_ESPUKF_data.TIME,...
    abs(LV_ESPUKF_data.error(:,7)),'-.k',LV_UKF_data.TIME,abs(LV_UKF_data.error(:,7)),'k')
grid on
xlabel('Time (s)')
ylabel('Acceleration Error (m)')
legend('EKF','SPUKF','ESPUKF','UKF')

figure
subplot(3,2,1)
plot(LV_EKF_data.TIME,abs(LV_EKF_data.ER(:,1)),'--k',LV_SPUKF_data.TIME,abs(LV_SPUKF_data.ER(:,1)),':k',LV_ESPUKF_data.TIME,...
    abs(LV_ESPUKF_data.ER(:,1)),'-.k',LV_UKF_data.TIME,abs(LV_UKF_data.ER(:,1)),'k')
grid on
xlabel('Time (s)')
ylabel('X axis Error (m)')

subplot(3,2,3)
plot(LV_EKF_data.TIME,abs(LV_EKF_data.ER(:,2)),'--k',LV_SPUKF_data.TIME,abs(LV_SPUKF_data.ER(:,2)),':k',LV_ESPUKF_data.TIME,...
    abs(LV_ESPUKF_data.ER(:,2)),'-.k',LV_UKF_data.TIME,abs(LV_UKF_data.ER(:,2)),'k')
grid on
xlabel('Time (s)')
ylabel('Y axis Error (m)')

subplot(3,2,5)
plot(LV_EKF_data.TIME,abs(LV_EKF_data.ER(:,3)),'--k',LV_SPUKF_data.TIME,abs(LV_SPUKF_data.ER(:,3)),':k',LV_ESPUKF_data.TIME,...
    abs(LV_ESPUKF_data.ER(:,3)),'-.k',LV_UKF_data.TIME,abs(LV_UKF_data.ER(:,3)),'k')
grid on
xlabel('Time (s)')
ylabel('Z axis Error (m)')

subplot(3,2,2)
plot(LV_EKF_data.TIME,abs(LV_EKF_data.EV(:,1)),'--k',LV_SPUKF_data.TIME,abs(LV_SPUKF_data.EV(:,1)),':k',LV_ESPUKF_data.TIME,...
    abs(LV_ESPUKF_data.EV(:,1)),'-.k',LV_UKF_data.TIME,abs(LV_UKF_data.EV(:,1)),'k')
grid on
xlabel('Time (s)')
ylabel('X axis velocity Error (m/s)')

subplot(3,2,4)
plot(LV_EKF_data.TIME,abs(LV_EKF_data.EV(:,2)),'--k',LV_SPUKF_data.TIME,abs(LV_SPUKF_data.EV(:,2)),':k',LV_ESPUKF_data.TIME,...
    abs(LV_ESPUKF_data.EV(:,2)),'-.k',LV_UKF_data.TIME,abs(LV_UKF_data.EV(:,2)),'k')
grid on
xlabel('Time (s)')
ylabel('Y axis  velocity Error (m/s)')

subplot(3,2,6)
plot(LV_EKF_data.TIME,abs(LV_EKF_data.EV(:,3)),'--k',LV_SPUKF_data.TIME,abs(LV_SPUKF_data.EV(:,3)),':k',LV_ESPUKF_data.TIME,...
    abs(LV_ESPUKF_data.EV(:,3)),'-.k',LV_UKF_data.TIME,abs(LV_UKF_data.EV(:,3)),'k')
grid on
xlabel('Time (s)')
ylabel('Z axis velocity Error (m/s)')
legend('EKF','SPUKF','ESPUKF','UKF')