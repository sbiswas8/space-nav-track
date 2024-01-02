function [v_mat, p_mat, nos] = visibility_extract(GPSM)
n = length(GPSM);
v_mat = nan(31,n);
p_mat = nan(31,n);
nos = nan(n,1);

for i = 1:n
    ns = 0;
    for j = 1:length(GPSM(i).PRN)
        prn = GPSM(i).PRN(j);
        if GPSM(i).POW(j) > -200
            ns = ns+1;
            v_mat(prn,i) = prn;
            p_mat(prn,i) = GPSM(i).POW(j);
        end
    end
    nos(i) = ns;
end