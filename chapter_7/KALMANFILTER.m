function [Estimated_state State_covariance residual_cov delX K] = KALMANFILTER(X_priori,delZ,Hx,P,R)

S = R + Hx*P*Hx';
K = P*Hx'*S^-1;
Estimated_state = X_priori + (K*delZ)';
delX = K*delZ;

State_covariance = (eye(6) - K*Hx)*P*((eye(6) - K*Hx)') + K*R*(K');
residual_cov = S;
end