function [P Estimated_state delRAE delX K RC] = RAE_UPDATE(X_priori,time,phi,lambda,Z,P,R_rae)
[HxRAE Z_RAE] = partialRAE(X_priori,time,phi,lambda);
delRAE = (Z - Z_RAE)';
%W = norm(X_priori(1:3));
f_max = 500;
t_max = 20082*10;
%factor = 10 + (f_max - 10)/t_max*time;
factor = 1;
R_r = (R_rae(1)*factor)^2;
R_a = R_rae(2)^2;
R_e = R_rae(3)^2;
R = [R_r 0 0;...
    0 R_a 0;...
    0 0 R_e];
% K = zeros(6,3);
% RC = zeros(1,3);
[Estimated_state,State_covariance,RC,delX,K] = KALMANFILTER(X_priori,delRAE,...
                                HxRAE,P,R);
P = State_covariance;

% [Estimated_state,State_covariance,RC(2),delXA,K(:,2)] = KALMANFILTER(X_priori,delRAE(2),...
%                                 HxRAE(2,:),P,R_a);
% P = State_covariance;
% 
% 
% [HxRAE Z_RAE] = partialRAE(Estimated_state,time,phi,lambda);
% delRAE(3) = Z(3) - Z_RAE(3);
% [Estimated_state,State_covariance,RC(3),delXE,K(:,3)] = KALMANFILTER(Estimated_state,delRAE(3),...
%                                 HxRAE(3,:),P,R_e);
% P = State_covariance;
% 
% [HxRAE Z_RAE] = partialRAE(Estimated_state,time,phi,lambda);
% delRAE(1) = Z(1) - Z_RAE(1);
% 
% [Estimated_state State_covariance RC(1) delXR K(:,1)] = KALMANFILTER(Estimated_state,delRAE(1),...
%                                 HxRAE(1,:),P,R_r);
%  P = State_covariance;


%delX = [delXR delXA delXE];                            

