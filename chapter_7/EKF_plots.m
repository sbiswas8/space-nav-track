%**************************************************************************
%EKF Results plot
%**************************************************************************
clc
%clear all
close all
t = 0:1:(iteration)*sampt;
%load 'EKF_results'
%load 'covariance'

error_EKF = X_true(1:length(X_filter),:) - X_filter;
covariance1 = [3^2 3^2 3^2 0.01^2 0.01^2 0.01^2; covariance];
cov_EKF = nan(length(covariance),6);
for i = 1:sampt:iteration*sampt
    for j = 1:sampt
        cov_EKF(i-1+j,:) = covariance1(i,:);
    end
end
cov_EKF = [cov_EKF;covariance1(end,:)];

error = X_true - X_true;

error_EKF_R = sqrt(error_EKF(:,1).^2 + error_EKF(:,2).^2 + error_EKF(:,3).^2);
error_EKF_V = sqrt(error_EKF(:,4).^2 + error_EKF(:,5).^2 + error_EKF(:,6).^2);
RR = sqrt(X_true(1:length(X_filter),1).^2 + X_true(1:length(X_filter),2).^2 + X_true(1:length(X_filter),3).^2);
RV = sqrt(X_true(1:length(X_filter),4).^2 + X_true(1:length(X_filter),5).^2 + X_true(1:length(X_filter),6).^2);
Rf = sqrt(X_filter(:,1).^2 + X_filter(:,2).^2 + X_filter(:,3).^2);
Vf = sqrt(X_filter(:,4).^2 + X_filter(:,5).^2 + X_filter(:,6).^2);
error_R = RR - Rf;
error_V = RV - Vf;

sigma_EKF = sqrt(cov_EKF);
sigma_prop = sqrt(cov);

sigma_EKF_R = sqrt(cov_EKF(:,1) + cov_EKF(:,2) + cov_EKF(:,3));
sigma_EKF_V = sqrt(cov_EKF(:,4) + cov_EKF(:,5) + cov_EKF(:,6));

sigma_R = sqrt(cov(:,1) + cov(:,2) + cov(:,3));
sigma_V = sqrt(cov(:,4) + cov(:,5) + cov(:,6));
%%


figr = figure;
subplot(3,1,1)
plot(t/60,error_EKF(1:length(t),1),'b',t/60,1*sigma_EKF(1:length(t),1),'r',t/60,-1*sigma_EKF(1:length(t),1),'r')
set(gca,'FontSize',15,'FontName','Times New Roman')
%xlabel('Time (Minute)','FontSize',15,'FontName','Times New Roman')
ylabel({'Postition error', 'in X axis (km)'},'FontSize',15,'FontName','Times New Roman')
grid on
%title('Postition error in X direction using EKF','FontSize',20,'FontName','Times New Roman')

subplot(3,1,2)
plot(t/60,error_EKF(1:length(t),2),'b',t/60,1*sigma_EKF(1:length(t),2),'r',t/60,-1*sigma_EKF(1:length(t),2),'r')
set(gca,'FontSize',15,'FontName','Times New Roman')
%xlabel('Time (Minute)','FontSize',20,'FontName','Times New Roman')
ylabel({'Postition error', 'in Y axis (km)'},'FontSize',15,'FontName','Times New Roman')
grid on
%title('Postition error in Y direction using EKF','FontSize',20,'FontName','Times New Roman')

subplot(3,1,3)
plot(t/60,error_EKF(1:length(t),3),'b',t/60,1*sigma_EKF(1:length(t),3),'r',t/60,-1*sigma_EKF(1:length(t),3),'r')
set(gca,'FontSize',15,'FontName','Times New Roman')
xlabel('Time (Minute)','FontSize',15,'FontName','Times New Roman')
ylabel({'Postition error', 'in Z axis (km)'},'FontSize',15,'FontName','Times New Roman')
grid on
legend('Error using EKF','1\sigma','Location','best')
legend boxoff
%axp = gca;
cleanfigure('targetResolution', 20)
%matlab2tikz('G:\My Drive\My_books\Chapter_7\Figures\tikz\pos_Error.tikz','floatFormat', '%0.3f')
%saveas(figp, 'G:\My Drive\My_books\Chapter_7\Figures\pos_Error.pdf', 'pdf')
%exportgraphics(axp, 'G:\My Drive\My_books\Chapter_7\Figures\pos_Error.pdf')
%title('Postition error in Z direction using EKF','FontSize',20,'FontName','Times New Roman')

%%



figv = figure;
subplot(3,1,1)
plot(t/60,error_EKF(1:length(t),4)*1000,'b',t/60,1*sigma_EKF(1:length(t),4)*1000,'r',t/60,-1*sigma_EKF(1:length(t),4)*1000,'r')
set(gca,'FontSize',15,'FontName','Times New Roman')
%xlabel('Time (Minute)','FontSize',20,'FontName','Times New Roman')
ylabel({'V_x error (m/s)'},'FontSize',15,'FontName','Times New Roman')
grid on
legend('Error using EKF','1\sigma','Location','northeast')
legend boxoff
%title('Velocity error in X direction using EKF','FontSize',20,'FontName','Times New Roman')

subplot(3,1,2)
plot(t/60,error_EKF(1:length(t),5)*1000,'b',t/60,1*sigma_EKF(1:length(t),5)*1000,'r',t/60,-1*sigma_EKF(1:length(t),5)*1000,'r')
set(gca,'FontSize',15,'FontName','Times New Roman')
%xlabel('Time (Minute)','FontSize',20,'FontName','Times New Roman')
ylabel({'V_y error (m/s)'},'FontSize',15,'FontName','Times New Roman')
grid on
%title('Velocity error in Y direction using EKF','FontSize',20,'FontName','Times New Roman')

subplot(3,1,3)
plot(t/60,error_EKF(1:length(t),6)*1000,'b',t/60,1*sigma_EKF(1:length(t),6)*1000,'r',t/60,-1*sigma_EKF(1:length(t),6)*1000,'r')
set(gca,'FontSize',15,'FontName','Times New Roman')
xlabel('Time (Minute)','FontSize',15,'FontName','Times New Roman')
ylabel({'V_z error (m/s)'},'FontSize',15,'FontName','Times New Roman')
grid on
%axv = gca;
cleanfigure('targetResolution', 20)
%matlab2tikz('G:\My Drive\My_books\Chapter_7\Figures\tikz\vel_Error.tikz','floatFormat', '%0.3f')
%saveas(figv, 'G:\My Drive\My_books\Chapter_7\Figures\vel_Error.pdf', 'pdf')
%exportgraphics(axv, 'G:\My Drive\My_books\Chapter_7\Figures\vel_Error.pdf')
%title('Velocity error in Z direction using EKF','FontSize',20,'FontName','Times New Roman')


%%


% figure
% set(gca,'FontSize',20,'FontName','Times New Roman')
% subplot(2,2,1)
% plot(t/60,sigma_EKF(:,1),t/60,sigma_prop(1:length(t),1))
% xlabel('Time (Minute)','FontSize',20,'FontName','Times New Roman')
% ylabel('\sigma_x^2 (km^2)','FontSize',20,'FontName','Times New Roman')
% grid on
% title('Position uncertainty in X direction using EKF','FontSize',20,'FontName','Times New Roman')
% 
% subplot(2,2,2)
% plot(t/60,sigma_EKF(:,2),t/60,sigma_prop(1:length(t),2))
% xlabel('Time (Minute)','FontSize',20,'FontName','Times New Roman')
% ylabel('\sigma_y^2 (km^2)','FontSize',20,'FontName','Times New Roman')
% grid on
% title('Position uncertinty in Y direction using EKF','FontSize',20,'FontName','Times New Roman')
% 
% subplot(2,2,3)
% plot(t/60,sigma_EKF(:,3),t/60,sigma_prop(1:length(t),3))
% xlabel('Time (Minute)','FontSize',20,'FontName','Times New Roman')
% ylabel('\sigma_z^2 (km^2)','FontSize',20,'FontName','Times New Roman')
% grid on
% legend('Standard daviation using EKF','Standard daviation corresponding to only propagation')
% title('Position uncertinty in Z direction using EKF','FontSize',20,'FontName','Times New Roman')


%%


% figure
% set(gca,'FontSize',20,'FontName','Times New Roman')
% subplot(2,2,1)
% plot(t/60,sigma_EKF(:,4),t/60,sigma_prop(1:length(t),4))
% xlabel('Time (Minute)','FontSize',20,'FontName','Times New Roman')
% ylabel('\sigma_x^2 ((km/s)^2)','FontSize',20,'FontName','Times New Roman')
% grid on
% title('Velocity uncertinty in X direction using EKF','FontSize',20,'FontName','Times New Roman')
% 
% subplot(2,2,2)
% plot(t/60,sigma_EKF(:,5),t/60,sigma_prop(1:length(t),5))
% xlabel('Time (Minute)','FontSize',20,'FontName','Times New Roman')
% ylabel('\sigma_y^2 ((km/s)^2)','FontSize',20,'FontName','Times New Roman')
% grid on
% title('Velocity uncertinty in Y direction using EKF','FontSize',20,'FontName','Times New Roman')
% 
% 
% subplot(2,2,3)
% plot(t/60,sigma_EKF(:,6),t/60,sigma_prop(1:length(t),6))
% xlabel('Time (Minute)','FontSize',20,'FontName','Times New Roman')
% ylabel('\sigma_z^2 ((km/s)^2)','FontSize',20,'FontName','Times New Roman')
% grid on
% legend('Standard daviation using EKF','Standard daviation corresponding to only propagation')
% title('Velocity uncertinty in Z direction using EKF','FontSize',20,'FontName','Times New Roman')

%%

figure
subplot(2,1,1)
plot(t/60,error_EKF_R(1:length(t)),t/60,1*sigma_EKF_R(1:length(t)),'r')
grid on
xlabel('Time(minute)','FontSize',20,'FontName','Times New Roman')
ylabel('Error in km','FontSize',20,'FontName','Times New Roman')
legend('Error using EKF','1\sigma')
%title('Position error','FontSize',20,'FontName','Times New Roman')

subplot(2,1,2)
plot(t/60,error_EKF_V(1:length(t))*1000,t/60,1*sigma_EKF_V(1:length(t))*1000,'r')
grid on
xlabel('Time(minute)','FontSize',20,'FontName','Times New Roman')
ylabel('Error in m/s','FontSize',20,'FontName','Times New Roman')
%title('Velocity error','FontSize',20,'FontName','Times New Roman')

%%

% figure
% subplot(2,1,1)
% plot(t/60,sigma_EKF_R,t/60,sigma_R(1:length(t)))
% grid on
% xlabel('Time in minute')
% ylabel('Standard daviation in position error (km)')
% title('Position standard daviation')
% 
% subplot(2,1,2)
% plot(t/60,sigma_EKF_V,t/60,sigma_V(1:length(t)))
% grid on
% xlabel('Time in minute')
% ylabel('Standard daviation in velocity error (km/s)')
% legend('Standard daviation using EKF','Standard daviation corresponding to only propagation')
% title('Position standard daviation')
%% 3d plot
% load X_m
% figure
% plot3(X_true(:,1),X_true(:,2),X_true(:,3),'r',X_m(:,1),X_m(:,2),X_m(:,3),'b', X_m(1,1),X_m(1,2),X_m(1,3),'ob', X_m(end,1),X_m(end,2),X_m(end,3),'ob')
% axis equal
% set(gca,'FontSize',15,'FontName','Times New Roman')
% text(0,0,0,'\leftarrow Earth','FontSize',15,'FontName','Times New Roman')
% text(X_m(1,1),X_m(1,2),X_m(1,3),'\leftarrow Moon at injection','FontSize',15,'FontName','Times New Roman')
% text(X_m(end,1),X_m(end,2),X_m(end,3),'\leftarrow Moon during capture','FontSize',15,'FontName','Times New Roman')
% hold on
% grid on
% [X Y Z] = sphere(20);
% mesh(6378.1*X,6378.1*Y,6378.1*Z)
% xlabel('X axis(km)','FontSize',15,'FontName','Times New Roman')
% ylabel('Y axis (km)','FontSize',15,'FontName','Times New Roman')
% zlabel('Z axis (km)','FontSize',15,'FontName','Times New Roman')
% ylim([-1 4]*10^5)
% cleanfigure('targetResolution', 300)
% matlab2tikz('G:\My Drive\My_books\Chapter_7\Figures\tikz\trajectory.tikz','floatFormat', '%0.3f')