function phi = numeric(DEL_F,t_step)
% A = [-DEL_F Q;
%      zeros(6) DEL_F']*t_step;
%  B = expm(A);
 
phi = expm(DEL_F*t_step);
% Qk = phi*B(1:6,7:12);
%  Qk = 0;
end
% alpha = 1;
% PHI = expm(DEL_F*t_step);
% aug1 = [(alpha*t_step - 1 +exp(-alpha*t_step))*ones(3,1);
%     (1)
% phi = [PHI ]
% etaV = Q(1);
% etaA = Q(2);
% 
% Qk = [(etaV*t_step + etaA*t_step^3/3)*eye(3) etaA*t_step^2/2*eye(3);
%     etaA*t_step^2/2*eye(3) etaA*t_step*eye(3)];                                                                                                                                                                                                                                            