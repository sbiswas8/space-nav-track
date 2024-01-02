function [V W] = VW(n,m,r,V1,V2,W1,W2)
z = r(3);
R = 6378.1;

V = (2*n-1)/(n-m)*z*R/norm(r)^2 *V1 - (n+m-1)/(n-m)*R^2/norm(r)^2*V2;

W = (2*n-1)/(n-m)*z*R/norm(r)^2 *W1 - (n+m-1)/(n-m)*R^2/norm(r)^2*W2;

