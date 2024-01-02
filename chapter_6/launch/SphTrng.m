function [phi_, lambda_] = SphTrng(alp)
global Az phi lambda
A = pi/2 - Az;
%B = pi/2;
beta = asin(sin(phi)/sin(A));
C = asin(sin(lambda)*sin(A)/sin(phi));
beta_ = beta + alp;
phi_ = asin(sin(A)*sin(beta_));
lambda_ = asin(sin(C)*sin(beta_));
