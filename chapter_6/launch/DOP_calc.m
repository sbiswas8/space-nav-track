%% DOP calculation
clear all
R = 100;
load LV_data.mat
NS = [4 6 8 10];
for ct = 1:length(NS)
    for i = 1:length(Ref_R_ECEF)-1
        for j = 1:NS(ct)
            r = Ref_R_ECEF(i+1,:) - PVT_GPS(i).SP(j,:);
            G(j,:) = [r/norm(r) 1];
        end
        H = (G'*G)^-1;
        PDOP(ct,i) = R*sqrt(H(1,1) + H(2,2) + H(3,3));
    end
end

for i = 1:length(NS)
    avPDOP(i) = rms(PDOP(i,:));
end
save('avPDOP.mat','avPDOP')