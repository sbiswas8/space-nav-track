clc
clear all
close all
load MC_results_280323

n_run = 20;
dim = size(MC_results(1).error);
error = nan(dim(1), dim(2), n_run);
cov = nan(dim(1), dim(2), n_run);

for i = 1:n_run
    error(:,:,i) = MC_results(i).error;
    cov(:,:,i) = [MC_results(i).cov(1,:); MC_results(i).cov];
end

MC_error = mean(error,3);
MC_std = sqrt(mean(cov,3));

sample_std = std(error, 0, 3);
t_stk = (0:length(error)-1)/60;

MC_error = MC_error(1:100:end,:);
MC_std = MC_std(1:100:end,:);
sample_std = sample_std(1:100:end,:);
t_stk = t_stk(1:100:end);

figure
subplot(3,1,1)
plot(t_stk, MC_error(:,1), 'k',...
    t_stk, sample_std(:,1), '--k',...
    t_stk, MC_std(:,1), '--b', ...
    t_stk, -sample_std(:,1), '--k',...
    t_stk, -MC_std(:,1), '--b',...
    'LineWidth', 1.2)
set(gca,'FontSize',12);
xlabel('Time (min)', 'Fontsize', 15)
ylabel({'Error in', 'X axis (km)'}, 'Fontsize', 15)
%title('Error in X direction')
legend('Error', 'sample - \sigma', 'KF - \sigma', 'Location', 'best')
legend boxoff

subplot(3,1,2)
plot(t_stk, MC_error(:,2), 'k', t_stk, sample_std(:,2), '--k', t_stk, -sample_std(:,2), '--k', 'LineWidth', 1.2)
hold on
plot(t_stk, MC_std(:,2), '--b', t_stk, -MC_std(:,2), '--b', 'LineWidth', 1.2)
set(gca,'FontSize',12);
xlabel('Time (min)', 'Fontsize', 15)
ylabel({'Error in', 'Y axis (km)'}, 'Fontsize', 15)
%title('Error in Y direction')

subplot(3,1,3)
plot(t_stk, MC_error(:,3), 'k', t_stk, sample_std(:,3), '--k', t_stk, -sample_std(:,3), '--k', 'LineWidth', 1.2)
hold on
plot(t_stk, MC_std(:,3), '--b', t_stk, -MC_std(:,3), '--b', 'LineWidth', 1.2)
set(gca,'FontSize',12);
xlabel('Time (min)', 'Fontsize', 15)
ylabel({'Error in', 'Z axis (km)'}, 'Fontsize', 15)
%title('Error in Z direction')
cleanfigure;
matlab2tikz('G:\My Drive\My_books\Chapter_7\Figures\tikz\pos_error.tikz')

figure
subplot(3,1,1)
plot(t_stk, MC_error(:,4), 'k',...
    t_stk, sample_std(:,4), '--k',...
    t_stk, MC_std(:,4), '--b', ...
    t_stk, -sample_std(:,4), '--k',...
    t_stk, -MC_std(:,4), '--b',...
    'LineWidth', 1.2)
set(gca,'FontSize',12);
%xlabel('Time (min)', 'Fontsize', 15)
ylabel({'Velocity Error', 'in X axis (km/s)'}, 'Fontsize', 15)
%title('Error in X direction')
legend('Error', 'sample - \sigma', 'KF - \sigma', 'Location', 'best')
legend boxoff

subplot(3,1,2)
plot(t_stk, MC_error(:,5), 'k', t_stk, sample_std(:,5), '--k', t_stk, -sample_std(:,5), '--k', 'LineWidth', 1.2)
hold on
plot(t_stk, MC_std(:,5), '--b', t_stk, -MC_std(:,5), '--b', 'LineWidth', 1.2)
set(gca,'FontSize',12);
%xlabel('Time (min)', 'Fontsize', 15)
ylabel({'Velocity Error', 'in Y axis (km/s)'}, 'Fontsize', 15)
%title('Error in Y direction')

subplot(3,1,3)
plot(t_stk, MC_error(:,6), 'k', t_stk, sample_std(:,6), '--k', t_stk, -sample_std(:,6), '--k', 'LineWidth', 1.2)
hold on
plot(t_stk, MC_std(:,6), '--b', t_stk, -MC_std(:,6), '--b', 'LineWidth', 1.2)
set(gca,'FontSize',12);
xlabel('Time (min)', 'Fontsize', 15)
ylabel({'Velocity Error', 'in Z axis (km/s)'}, 'Fontsize', 15)
%title('Error in Z direction')
cleanfigure;
matlab2tikz('G:\My Drive\My_books\Chapter_7\Figures\tikz\vel_error.tikz')