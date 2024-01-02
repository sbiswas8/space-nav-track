%% Orbit eccentricity and semi major axis calculation

R = 6371; % radius of earth in km
e = [0.1 0.4 0.7 0.9];
h = 400;
a = (R+h)./(1-e);
b = a.*sqrt(1-e.^2);