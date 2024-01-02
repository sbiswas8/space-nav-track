function RHO = DrngHgt2rec(X)
global R_LS
Re_loc = norm(R_LS);
alp = X(1)/Re_loc;
%[phi_, lambda_] = SphTrng(alp);
%R1 = R_E^2/sqrt((R_E^2*cos(phi_) +b^2*sin(phi_)));
k = (Re_loc + X(2))*sin(alp);
l = (Re_loc + X(2))*cos(alp) - Re_loc;
RHO = [k;l;0];