clc
clear all
close all
addpath('./UKFs')
gps = GPS_data_read('GPS_data.csv');
obs_data(1).add = 'C:\Users\Sanat\Dropbox\PhD\Elliptical_orbit\Ecc1\ecc1_data.mat';
obs_data(2).add = 'C:\Users\Sanat\Dropbox\PhD\Elliptical_orbit\Ecc2\ecc2_data.mat';
obs_data(3).add = 'C:\Users\Sanat\Dropbox\PhD\Elliptical_orbit\Ecc3\ecc3_data.mat';
obs_data(4).add = 'C:\Users\Sanat\Dropbox\PhD\Elliptical_orbit\Ecc4\ecc4_data.mat';


R = 6371;
figure
[x,y,z] = sphere;
surf(x*R,y*R,z*R)
hold on
 for i = 1:4
     orbit_plot(obs_data(i).add)
 end
 for i = 1:31
     plot3(gps(i).R(:,1),gps(i).R(:,2),gps(i).R(:,3),':')
 end
 axis equal
 view(3)
 cleanfigure('targetResolution',20)
 matlab2tikz('C:\Users\sanat\Google Drive\MyPapers\Conference\ICC\Tikz\orbit3d.tikz','floatFormat', '%0.3f')