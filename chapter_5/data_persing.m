%% data persing
clc
clear all
addpath('.\UKFs')
for i = 1:4
    switch i
        case 1
            sat_data = 'Ecc1\sat_data_V1A1.csv';
            log_file = 'Ecc1\elliptical_data.csv';
            rinex_file = 'C:\Users\sanat\Dropbox\PhD\Elliptical_orbit\Spirent\18_dec_2013.11N';
            msg = sprintf('Processing: Case 1');
            fprintf(msg);
            m = numel(msg);
            [Ref_R_ECEF, Ref_V_ECEF, GPSM, PVT_GPS, EPH] = sprntdata_rd(sat_data,log_file,rinex_file);
            save('Ecc1\ecc1_data','Ref_R_ECEF', 'Ref_V_ECEF', 'GPSM', 'PVT_GPS','EPH');
        case 2
            sat_data = 'Ecc2\sat_data_V1A1.csv';
            log_file = 'Ecc2\elliptical_data.csv';
            rinex_file = 'C:\Users\sanat\Dropbox\PhD\Elliptical_orbit\Spirent\18_dec_2013.11N';
            msg = sprintf('Processing: Case 2');
            fprintf(repmat('\b',1,m));
            fprintf(msg);
            m = numel(msg);
            [Ref_R_ECEF, Ref_V_ECEF, GPSM, PVT_GPS, EPH] = sprntdata_rd(sat_data,log_file,rinex_file);
            save('Ecc2\ecc2_data','Ref_R_ECEF', 'Ref_V_ECEF', 'GPSM', 'PVT_GPS','EPH');
        case 3
            sat_data = 'Ecc3\sat_data_V1A1.csv';
            log_file = 'Ecc3\elliptical_data.csv';
            rinex_file = 'C:\Users\sanat\Dropbox\PhD\Elliptical_orbit\Spirent\18_dec_2013.11N';
            msg = sprintf('Processing: Case 3');
            fprintf(repmat('\b',1,m));
            fprintf(msg);
            m = numel(msg);
            [Ref_R_ECEF, Ref_V_ECEF, GPSM, PVT_GPS, EPH] = sprntdata_rd(sat_data,log_file,rinex_file);
            save('Ecc3\ecc3_data','Ref_R_ECEF', 'Ref_V_ECEF', 'GPSM', 'PVT_GPS','EPH');
        case 4
            sat_data = 'Ecc4\sat_data_V1A1.csv';
            log_file = 'Ecc4\elliptical_data.csv';
            rinex_file = 'C:\Users\sanat\Dropbox\PhD\Elliptical_orbit\Spirent\18_dec_2013.11N';
            msg = sprintf('Processing: Case 4');
            fprintf(repmat('\b',1,m));
            fprintf(msg);
            m = numel(msg);
            [Ref_R_ECEF, Ref_V_ECEF, GPSM, PVT_GPS, EPH] = sprntdata_rd(sat_data,log_file,rinex_file);
            save('Ecc4\ecc4_data','Ref_R_ECEF', 'Ref_V_ECEF', 'GPSM', 'PVT_GPS','EPH');
    end
end