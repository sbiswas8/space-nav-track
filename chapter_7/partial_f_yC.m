function DEL_F = partial_f_yC(R_moon,X_ref)
X = X_ref;
r_m = R_moon;
R0 = [X(1) X(2) X(3)];

G = 6.673e-20;
M_e = 5.9742e24;
M_m = 5.9742e24/81;

R_sm = R0 - r_m;

x = R0(1);
y = R0(2);
z = R0(3);

xr = R_sm(1);
yr = R_sm(2);
zr = R_sm(3);

r_mod = norm(R0);
R_sm_mod = norm(R_sm);

ZERO = zeros(3,3);
I = eye(3);

%PARTIAL_a_v = zeros(3,3);

T11 = 3*x^2 - r_mod^2;
T12 = 3*x*y;
T13 = 3*z*x;
T21 = 3*x*y;
T22 = 3*y^2 - r_mod^2;
T23 = 3*y*z;
T31 = 3*z*x;
T32 = 3*y*z;
T33 = 3*z^2 - r_mod^2;

PARTIAL_a_r_earth = G*M_e/r_mod^5*[T11 T12 T13;
                                   T21 T22 T23;
                                   T31 T32 T33];

Tm11 = 3*xr^2 - R_sm_mod^2;
Tm12 = 3*xr*yr;
Tm13 = 3*zr*xr;
Tm21 = 3*xr*yr;
Tm22 = 3*yr^2 - R_sm_mod^2;
Tm23 = 3*yr*zr;
Tm31 = 3*zr*xr;
Tm32 = 3*yr*zr;
Tm33 = 3*zr^2 - R_sm_mod^2;

PARTIAL_a_r_moon = G*M_m/R_sm_mod^5*[Tm11 Tm12 Tm13;
                                     Tm21 Tm22 Tm23;
                                     Tm31 Tm32 Tm33];

PARTIAL_a_r = PARTIAL_a_r_earth + PARTIAL_a_r_moon;

DEL_F = [ZERO I; PARTIAL_a_r ZERO];