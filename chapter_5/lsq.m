function [X_out, del] = lsq(A,del_rho,X_in)
del = (A'*A)^-1*A'*del_rho;
X_out = X_in + del;