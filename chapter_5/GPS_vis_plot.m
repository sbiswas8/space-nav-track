%% GPS visibility from various orbits
clc
clear all
close all
obs_data(1).add = 'C:\Users\sanat\Dropbox\PhD\Elliptical_orbit\Ecc1\ecc1_data.mat';
obs_data(2).add = 'C:\Users\sanat\Dropbox\PhD\Elliptical_orbit\Ecc2\ecc2_data.mat';
obs_data(3).add = 'C:\Users\sanat\Dropbox\PhD\Elliptical_orbit\Ecc3\ecc3_data.mat';
obs_data(4).add = 'C:\Users\sanat\Dropbox\PhD\Elliptical_orbit\Ecc4\ecc4_data.mat';
%n = 12000;
e = [0.1 0.4 0.7 0.9];
visibilityplot(obs_data,e)
% for i=1:4
%     obs_add = obs_data(i).add;
%     
% end