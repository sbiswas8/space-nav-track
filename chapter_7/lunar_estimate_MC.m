clc
clear all
close all

n_run = 20;
MC_results = [];
parfor r_count = 1:n_run
    [error_EKF, cov_EKF_WD] = EKF_with_delays_MC();
    MC_results(r_count).error = error_EKF;
    MC_results(r_count).cov = cov_EKF_WD;
end
t_s = length(MC_results(1).error);
n_run_average_error = [];
for i = 1:t_s
    n_run_average_error(i) = 0;
    for j = 1:n_run
        n_run_average_error(i) = n_run_average_error(i) + norm(MC_results(j).error(i,1:3));
    end
    n_run_average_error(i) = n_run_average_error(i)/n_run;
end