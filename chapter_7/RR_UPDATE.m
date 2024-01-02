function [P Estimated_state delRR delX K RC_RR] = RR_UPDATE(X_priori,time,phi,lambda,range_rate,P,R_rr)
[HxRR Z_cap] = partialRR(X_priori,time,phi,lambda);
delRR = range_rate - Z_cap;
[Estimated_state State_covariance RC_RR delX K] = KALMANFILTER(X_priori,delRR,...
                                HxRR,P,R_rr);
P = State_covariance;
%Estimated_state = Estimated_state - [delX(1) delX(2) delX(3) 0 0 0];
%Estimated_state = Estimated_state - delX';
