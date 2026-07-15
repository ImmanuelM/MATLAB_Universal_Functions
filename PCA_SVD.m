%% PCA (Using SVD)
%function [U,Fe] = PCA_SVD(Y);

%U -> factor loading matrix
%Fe -> factors
%Y - KxN K-> variables N-> observations

function [U,Fe] = PCA_SVD(Y);

Cov = Y*Y';

[Q,S,~] = svd(Cov);

U = Q*S^0.5;
Fe = (S^(-0.5))*Q'*Y;


return