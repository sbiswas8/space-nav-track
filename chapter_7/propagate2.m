function [cov P Qk] = propagate2(R_moon,X_prop,P,t_step,t_sim)
cov = zeros(size(R_moon,1)-1,6);
R_E = 6378.1;
 
sigmaAsq = 1e-6;
sigmaVsq = 1e-6;


% Qk = [(sigmaVsq*t_step + sigmaAsq*t_step^3/3)*eye(3) sigmaAsq*t_step^2/2*eye(3);...
%     sigmaAsq*t_step^2/2*eye(3) sigmaAsq*t_step*eye(3)];

Q = [sigmaVsq*eye(3) zeros(3);zeros(3) sigmaAsq*eye(3)];
% Qk = sigmaVsq*[1/4*t_step^4*eye(3) 1/2*t_step^3*eye(3);
%         1/2*t_step^3*eye(3) t_step^2*eye(3)];
%   Pfm = [sqrt(1.002) 0 0;0 sqrt(1.002) 0; 0 0 sqrt(1.002)];
% PF = [Pfm zeros(3);zeros(3) eye(3)];

  
for count = 1:size(R_moon,1)-1
        DEL_F0 =  Fmat(R_moon(count,:),X_prop(count,:),t_sim(count));
        DEL_F = Fmat(R_moon(count+1,:),X_prop(count+1,:),t_sim(count+1));
        G0 = DEL_F0(4:6,1:3);
        G = DEL_F(4:6,1:3);
        
        phi_rr = eye(3) + (2*G0+G)*t_step^2/6;
        phi_rv = eye(3)*t_step + (G0+G)*t_step^3/12;
        phi_vr = (G0+G)*t_step/2;
        phi_vv = eye(3) + (G0+2*G)*t_step^2/6;
        phi = [phi_rr phi_rv;phi_vr phi_vv];
        %sigmaAsq = sigmaAsq*(R_E/norm(X_prop(count,1:3)))^2;
        %sigmaAsq = sigmaAsq*2.82*10^20/norm(X_prop(count,1:3))^8;
        %Q = [sigmaVsq*eye(3) zeros(3);zeros(3) sigmaAsq*eye(3)];
        P_dot = DEL_F*P + P*DEL_F' + Q;
        P = P_dot*t_step + P;
      
        Qk = [(sigmaVsq*t_step + sigmaAsq*t_step^3/3)*eye(3) sigmaAsq*t_step^2/2*eye(3);...
               sigmaAsq*t_step^2/2*eye(3) sigmaAsq*t_step*eye(3)];
%         P = phi*P*phi' + Qk;
         %P = PF*P*PF;  
        cov(count,:) = [P(1,1) P(2,2) P(3,3) P(4,4) P(5,5) P(6,6)];
end
end