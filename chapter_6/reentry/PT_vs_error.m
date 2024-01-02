clc
%close all
clear all

normp = @(x)sqrt(x(:,1).^2 + x(:,1).^2);

load RV_EKFdata
load RV_SPUKFdata
load RV_ESPUKFdata
load RV_UKFdata

PT(1) = RV_EKFdata.profile.FunctionTable(4).TotalTime/200*1000;
PT(2) = RV_SPUKFdata.profile.FunctionTable(3).TotalTime/200*1000;
PT(3) = RV_ESPUKFdata.profile.FunctionTable(3).TotalTime/200*1000;
PT(4) = RV_UKFdata.profile.FunctionTable(3).TotalTime/200*1000;
err(1) = mean(normp(RV_EKFdata.error));
err(2) = mean(normp(RV_SPUKFdata.error));
err(3) = mean(normp(RV_ESPUKFdata.error));
err(4) = mean(normp(RV_UKFdata.error));

figure
stairs(PT,err,'o-k')
xlim([0,26])
ylim([300,4000])
set(gca,'FontSize',15,'FontName','Times New Roman')
grid on
xlabel('Processing time per time step (ms)','FontSize',15,'FontName','Times New Roman')
ylabel('Average position error (m)','FontSize',15,'FontName','Times New Roman')
[x1,y1] = ds2nfu(PT(1),err(1));
[x2,y2] = ds2nfu(5,err(1));
annotation('textarrow',[x2,x1],[y2,y1],...
           'String','EKF','FontSize',15,'FontName','Times New Roman')
[x1,y1] = ds2nfu(PT(2),err(2));
[x2,y2] = ds2nfu(5,1500);
annotation('textarrow',[x2,x1],[y2,y1],...
           'String','SPUKF(new)','FontSize',15,'FontName','Times New Roman')

[x1,y1] = ds2nfu(PT(3),err(3));
[x2,y2] = ds2nfu(10,1200);
annotation('textarrow',[x2,x1],[y2,y1],...
           'String','ESPUKF(new)','FontSize',15,'FontName','Times New Roman')

[x1,y1] = ds2nfu(PT(4),err(4));
[x2,y2] = ds2nfu(23,err(4));
annotation('textarrow',[x2,x1],[y2,y1],...
           'String','UKF','FontSize',15,'FontName','Times New Roman')


