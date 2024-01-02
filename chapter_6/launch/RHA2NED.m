function R = RHA2NED(x,h,Az)
N = x*cos(Az);
E = x*sin(Az);
D = -h;
R = [N E D];