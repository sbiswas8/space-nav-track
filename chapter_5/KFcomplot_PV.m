function [] = KFcomplot_PV(error_t,time,e)
t = 0:time-1;
EKFP_err = error_t.EKFP_err;
UKFP_err = error_t.UKFP_err;
SPUKFP_err = error_t.SPUKFP_err;
ESPUKFP_err = error_t.ESPUKFP_err;

EKFV_err = error_t.EKFV_err;
UKFV_err = error_t.UKFV_err;
SPUKFV_err = error_t.SPUKFV_err;
ESPUKFV_err = error_t.ESPUKFV_err;

figure
subplot(2,1,1)
plot(t,EKFP_err,'--k',t,UKFP_err,'--r',t,SPUKFP_err,'--g',t,ESPUKFP_err,'--b','LineWidth',1.2)
set(gca,'FontSize',10,'FontName','Times New Roman')
xlabel('Time (s)','FontSize',10,'FontName','Times New Roman')
ylabel('Position Error (m)','FontSize',10,'FontName','Times New Roman')
switch e
    case 0.1
        title('Orbit eccentricity 0.1')
    case 0.4
        title('Orbit eccentricity 0.4')
    case 0.7
        title('Orbit eccentricity 0.7')
    case 0.9
        title('Orbit eccentricity 0.9')
end
legend('EKF','UKF','SPUKF','ESPUKF')
subplot(2,1,2)
plot(t,EKFV_err,'--k',t,UKFV_err,'--b',t,SPUKFV_err,'--r',t,ESPUKFV_err,'--m','LineWidth',1.2)
set(gca,'FontSize',10,'FontName','Times New Roman')
xlabel('Time (s)','FontSize',10,'FontName','Times New Roman')
ylabel('Velocity Error (m/s)','FontSize',10,'FontName','Times New Roman')