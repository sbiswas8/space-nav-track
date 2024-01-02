function [V W] = VWm(m,r,V1,W1)
R = 6378.1;
x = r(1);
y = r(2);

V = (2*m-1)*(x*R/norm(r)^2*V1 - y*R/norm(r)^2*W1);

W = (2*m-1)*(x*R/norm(r)^2*W1 + y*R/norm(r)^2*V1);