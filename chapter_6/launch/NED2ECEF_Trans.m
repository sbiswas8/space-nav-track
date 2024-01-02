function T_ECEF = NED2ECEF_Trans(phi,lambda)
T_ECEF = [-sin(phi)*cos(lambda) -sin(lambda) -cos(phi)*cos(lambda);
    -sin(phi)*sin(lambda) cos(lambda) -cos(phi)*sin(lambda);
    cos(phi) 0 -sin(phi)];