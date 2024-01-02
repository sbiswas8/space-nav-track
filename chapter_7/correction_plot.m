clc
figure
set(gca,'FontSize',20,'FontName','Times New Roman')
subplot(3,2,1)
plot(t(1:length(del_XR))/60,del_XR(:,1),'*')
grid on
xlabel('Time (minute)','FontSize',12,'FontName','Times New Roman')
ylabel('Position Correction in X (km)','FontSize',10,'FontName','Times New Roman')
title('Range, Azimuth and Elevation correction','FontSize',12,'FontName','Times New Roman')

subplot(3,2,2)
plot(t(1:length(del_XR))/60,del_XR(:,2),'*')
grid on
xlabel('Time (minute)','FontSize',12,'FontName','Times New Roman')
ylabel('Position Correction in Y (km)','FontSize',10,'FontName','Times New Roman')
title('Range, Azimuth and Elevation correction','FontSize',12,'FontName','Times New Roman')

subplot(3,2,3)
plot(t(1:length(del_XR))/60,del_XR(:,3),'*')
grid on
xlabel('Time (minute)','FontSize',12,'FontName','Times New Roman')
ylabel('Position Correction in Z (km)','FontSize',10,'FontName','Times New Roman')
title('Range, Azimuth and Elevation correction','FontSize',12,'FontName','Times New Roman')

subplot(3,2,4)
plot(t(1:length(del_XR))/60,del_XR(:,4)*1000,'*')
grid on
xlabel('Time (minute)','FontSize',12,'FontName','Times New Roman')
ylabel('Velocity Correction in X (m/s)','FontSize',10,'FontName','Times New Roman')
title('Range, Azimuth and Elevation correction','FontSize',12,'FontName','Times New Roman')

subplot(3,2,5)
plot(t(1:length(del_XR))/60,del_XR(:,5)*1000,'*')
grid on
xlabel('Time (minute)','FontSize',12,'FontName','Times New Roman')
ylabel('Velocity Correction in Y (m/s)','FontSize',10,'FontName','Times New Roman')
title('Range, Azimuth and Elevation correction','FontSize',12,'FontName','Times New Roman')

subplot(3,2,6)
plot(t(1:length(del_XR))/60,del_XR(:,6)*1000,'*')
grid on
xlabel('Time (minute)','FontSize',12,'FontName','Times New Roman')
ylabel('Velocity Correction in Z (m/s)','FontSize',10,'FontName','Times New Roman')
title('Range, Azimuth and Elevation correction','FontSize',12,'FontName','Times New Roman')






figure
set(gca,'FontSize',20,'FontName','Times New Roman')
subplot(3,2,1)
plot(t(1:length(del_XRR))/60,del_XRR(:,1),'*')
grid on
xlabel('Time (minute)','FontSize',12,'FontName','Times New Roman')
ylabel('Position Correction in X (km)','FontSize',10,'FontName','Times New Roman')
title('Range Rate correction','FontSize',12,'FontName','Times New Roman')

subplot(3,2,2)
plot(t(1:length(del_XRR))/60,del_XRR(:,2),'*')
grid on
xlabel('Time (minute)','FontSize',12,'FontName','Times New Roman')
ylabel('Position Correction in Y (km)','FontSize',10,'FontName','Times New Roman')
title('Range Rate correction','FontSize',12,'FontName','Times New Roman')

subplot(3,2,3)
plot(t(1:length(del_XRR))/60,del_XRR(:,3),'*')
grid on
xlabel('Time (minute)','FontSize',12,'FontName','Times New Roman')
ylabel('Position Correction in Z (km)','FontSize',10,'FontName','Times New Roman')
title('Range, Rate correction','FontSize',12,'FontName','Times New Roman')

subplot(3,2,4)
plot(t(1:length(del_XRR))/60,del_XRR(:,4)*1000,'*')
grid on
xlabel('Time (minute)','FontSize',12,'FontName','Times New Roman')
ylabel('Velocity Correction in X (km)','FontSize',10,'FontName','Times New Roman')
title('Range Rate correction','FontSize',12,'FontName','Times New Roman')

subplot(3,2,5)
plot(t(1:length(del_XRR))/60,del_XRR(:,5)*1000,'*')
grid on
xlabel('Time (minute)','FontSize',12,'FontName','Times New Roman')
ylabel('Velocity Correction in Y (m/s)','FontSize',10,'FontName','Times New Roman')
title('Range Rate correction','FontSize',12,'FontName','Times New Roman')

subplot(3,2,6)
plot(t(1:length(del_XRR))/60,del_XRR(:,6)*1000,'*')
grid on
xlabel('Time (minute)','FontSize',12,'FontName','Times New Roman')
ylabel('Velocity Correction in Z (m/s)','FontSize',10,'FontName','Times New Roman')
title('Range Rate correction','FontSize',12,'FontName','Times New Roman')
