clc
%clear all
load LV_EKF_data.mat
load LV_SPUKF_data.mat
load LV_ESPUKF_data.mat
load LV_UKF_data.mat

EKF_MEAN(i,:) = [rms(LV_EKF_data.error(200:end,1)) rms(LV_EKF_data.error(200:end,2)) rms(LV_EKF_data.error(200:end,3)) rms(LV_EKF_data.error(200:end,7))];
SPUKF_MEAN(i,:) = [rms(LV_SPUKF_data.error(200:end,1)) rms(LV_SPUKF_data.error(200:end,2)) rms(LV_SPUKF_data.error(200:end,3)) rms(LV_SPUKF_data.error(200:end,7))];
ESPUKF_MEAN(i,:) = [rms(LV_ESPUKF_data.error(200:end,1)) rms(LV_ESPUKF_data.error(200:end,2)) rms(LV_ESPUKF_data.error(200:end,3)) rms(LV_ESPUKF_data.error(200:end,7))];
UKF_MEAN(i,:) = [rms(LV_UKF_data.error(200:end,1)) rms(LV_UKF_data.error(200:end,2)) rms(LV_UKF_data.error(200:end,3)) rms(LV_UKF_data.error(200:end,7))];