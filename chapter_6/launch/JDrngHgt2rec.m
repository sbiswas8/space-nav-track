function M = JDrngHgt2rec(X)
global R_LS
Re_loc = norm(R_LS);
alp = X(1)/Re_loc;
M(1,1) = (Re_loc + X(2))/Re_loc*cos(alp);
M(1,2) = sin(alp);

M(2,1) = -(Re_loc+X(2))/Re_loc*sin(alp);
M(2,2) = cos(alp);
M(3,1) = 0;
M(3,2) = 0;