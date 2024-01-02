function Z_e = h_rentry(X)
global R_e M

Phi = (M-X(2))/R_e;
dH = R_e - R_e.*cos(Phi);
dD = R_e.*sin(Phi);

Z_e(1,1) = sqrt((X(1)+dH)^2 + dD^2);
Z_e(2,1) = pi - (atan2((X(1)+dH),dD) - Phi);