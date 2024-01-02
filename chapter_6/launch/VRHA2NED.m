function V = VRHA2NED(v,lambda,Az)
N= v*cos(lambda)*cos(Az);
E = v*cos(lambda)*sin(Az);
D = -v*sin(lambda);
V = [N E D];