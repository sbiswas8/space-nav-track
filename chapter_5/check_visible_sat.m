function index = check_visible_sat(GPSM)
% returns index when nos is >=4
for i = 1:length(GPSM)
    visible_sat = length(GPSM(i).PRN);
    if visible_sat >= 4
        break;
    end
end
index = i;