clc
clear all
addpath('../estimation-algorithms')
profile off
dbstop error
obs_data(1).add = './Ecc1/ecc1_data.mat';
obs_data(2).add = './Ecc2/ecc2_data.mat';
obs_data(3).add = './Ecc3/ecc3_data.mat';

SAT_INI.NS = 8;
SAT_INI.STD = [5 5 5 1 1 1 0.1];
SAT_INI.Time = 500;
SAT_INI.EKFQk = 1e-1*eye(7);%diag([1e-6 1e-6 1e-6 1e-6 1e-6 1e-6 1e-1]);
SAT_INI.UKFQk = 1e-1*eye(7);
SAT_INI.del = [1 2 5 0.1 .1 .1 0]';
SAT_INI.sigmar = 20;
SAT_INI.sigmarr = 2;
FilterType(1).F = 'EKF';
FilterType(2).F = 'UKF';
FilterType(3).F = 'SPUKF';
FilterType(4).F = 'ESPUKF';
Estimate = struct([]);
fmsgl = 0;
e = [0.1 0.4 0.7 0.9];
for i = 1:3
    close all
    msg = sprintf('Processing: orbit eccentricity %.3f\n',e(i));
    fprintf(msg);
    omsgl = numel(msg);
    for j = 1:4
        [EST,fmsgl] = KF_sim(obs_data(i).add,SAT_INI,FilterType(j).F);
        fprintf(repmat('\b',1,fmsgl));
        switch FilterType(j).F
            case 'EKF'
                Estimate(i).EKF = EST;
            case 'UKF'
                Estimate(i).UKF = EST;
            case 'SPUKF'
                Estimate(i).SPUKF = EST;
            case 'ESPUKF'
                Estimate(i).ESPUKF = EST;
        end
    end
    fprintf(repmat('\b',1,omsgl));
end 

save Estimate_2 Estimate