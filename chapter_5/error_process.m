function [error_t, error_av] = error_process(data,time)
t = 0:time-1;
for i = 1:length(t)
    error_t.EKFP_err(i) = norm(data.EKF.error(i,1:3));
    error_t.UKFP_err(i) = norm(data.UKF.error(i,1:3));
    error_t.SPUKFP_err(i) = norm(data.SPUKF.error(i,1:3));
    error_t.ESPUKFP_err(i) = norm(data.ESPUKF.error(i,1:3));
    
    error_t.EKFV_err(i) = norm(data.EKF.error(i,4:6));
    error_t.UKFV_err(i) = norm(data.UKF.error(i,4:6));
    error_t.SPUKFV_err(i) = norm(data.SPUKF.error(i,4:6));
    error_t.ESPUKFV_err(i) = norm(data.ESPUKF.error(i,4:6));
end

error_av.EKF_avP = mean(error_t.EKFP_err);
error_av.UKF_avP = mean(error_t.UKFP_err);
error_av.SPUKF_avP = mean(error_t.SPUKFP_err);
error_av.ESPUKF_avP = mean(error_t.ESPUKFP_err);

error_av.EKF_avV = mean(error_t.EKFV_err);
error_av.UKF_avV = mean(error_t.UKFV_err);
error_av.SPUKF_avV = mean(error_t.SPUKFV_err);
error_av.ESPUKF_avV = mean(error_t.ESPUKFV_err);