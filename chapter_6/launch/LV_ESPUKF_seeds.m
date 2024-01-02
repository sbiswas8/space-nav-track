clc
clear all
close all
LV_INI.Q = diag([1e-10 1e-10 1e-3 1e-10 1e-3 1e-6 1e-3 1e-2 1e-2]);
% LV_INI.Q(1,1) = 1e-50;
% LV_INI.Q(2,2) = 1e-50;
% LV_INI.Q(3,3) = 1e-3;
% LV_INI.Q(4,4) = 1e-5;
% LV_INI.Q(5,5) = 1e-50;
% LV_INI.Q(6,6) = 1e-5;
% LV_INI.Q(7,7) = 1e-6;
% LV_INI.Q(8,8) = 1e-10;
% LV_INI.Q(9,9) = 1e-50;
LV_INI.R = [20 2];
LV_INI.delX = [0.1 0.1 1e-4 0 1e-3 1e-3 1e-2 1 2];
%LV_INI.delX = [2 3 .01 1e-6 0.001 .001 1e-2 1 2];
LV_INI.STD = [1 1 0.1 1e-8 1e-3 1e-2 .1 5 5]';
LV_INI.NS = 4;
save('LV_INI.mat','LV_INI')
rcnt = 1;
seeds_EKF = [];
NoR = 20;

while 1
    close all
    run LV_data_prcs
    run LV_EKF
    if error_flag == 1
        close all
        continue;
    end
    fprintf('%i\n', rcnt)
    s = rng;
    seeds_EKF(rcnt) = s.Seed;
    rcnt = rcnt + 1;
    EKF_MC(rcnt).Mean_error = LV_EKF_data.error;

    EKF_MC(rcnt).Mean_std = LV_EKF_data.STD;

    if rcnt>NoR
        break;
    end
end

fprintf('EKF done\n')
% seeds_SPUKF = [];
% rcnt = 1;
% while 1
%     close all
%     run LV_data_prcs
%     run LV_SPUKF
%     if error_flag == 1
%         close all
%         continue;
%     end
%     fprintf('%i\n', rcnt)
%     s = rng;
%     seeds_SPUKF(rcnt) = s.Seed;
%     %EKF_MC(rcnt).Mean_error = LV_EKF_data.error;
%     SPUKF_MC(rcnt).Mean_error = LV_SPUKF_data.error;
% 
%     %EKF_MC(rcnt).Mean_std = LV_EKF_data.STD;
%     SPUKF_MC(rcnt).Mean_std = LV_SPUKF_data.STD;
%     rcnt = rcnt + 1;
% 
%     if rcnt>NoR
%         break;
%     end
% end
% fprintf('SPUKF done\n')
% seeds_ESPUKF = [];
% rcnt = 1;
% while 1
%     close all
%     rng('shuffle', 'v5normal')
%     run LV_data_prcs
%     run LV_ESPUKF
%     if error_flag == 1
%         close all
%         continue;
%     end
% 
%     fprintf('%i\n', rcnt)
%     s = rng;
%     seeds_ESPUKF(rcnt) = s.Seed;
%     ESPUKF_MC(rcnt).Mean_error = LV_ESPUKF_data.error;
%     ESPUKF_MC(rcnt).Mean_std = LV_ESPUKF_data.STD;
%     rcnt = rcnt + 1;
%     if rcnt>NoR
%         break;
%     end
% end
% fprintf('ESPUKF done\n')
% seeds_UKF = [];
% rcnt = 1;
% while 1
%     close all
%     run LV_data_prcs
%    
%     run LV_UKF
%     if error_flag == 1
%         close all
%         continue;
%     end
%     fprintf('%i\n', rcnt)
%     s = rng;
%     seeds_UKF(rcnt) = s.Seed;
%     UKF_MC(rcnt).Mean_error = LV_UKF_data.error;
%     UKF_MC(rcnt).Mean_std = LV_UKF_data.STD;
%     rcnt = rcnt + 1;
%     if rcnt>NoR
%         break;
%     end
% end
% fprintf('UKF done\n')
% 
% save('MC_data_book_R2', 'EKF_MC', 'seeds_EKF', 'SPUKF_MC', 'seeds_SPUKF', 'ESPUKF_MC', 'seeds_ESPUKF', 'UKF_MC', 'seeds_UKF')