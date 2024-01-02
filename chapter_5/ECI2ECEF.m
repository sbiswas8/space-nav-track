function R_ECEF = ECI2ECEF(THETA,R_ECI)
R_ECEF_ECI = [cos(THETA) sin(THETA) 0;...
      -sin(THETA) cos(THETA) 0;...
      0 0 1];
  R_ECEF = R_ECEF_ECI*R_ECI;