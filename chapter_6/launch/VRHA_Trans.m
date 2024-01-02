function T_VRHA = VRHA_Trans(gamma,A)
T_VRHA = [cos(gamma)*cos(A); cos(gamma)*sin(A);-sin(gamma)];