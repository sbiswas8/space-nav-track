function T = rotation(X)
global R_LS
Re_loc = norm(R_LS);
alp = X/Re_loc;
T = [cos(alp) sin(alp) 0;-sin(alp) cos(alp) 0; 0 0 1];