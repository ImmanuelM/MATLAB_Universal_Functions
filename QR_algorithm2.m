function [model_order,Factor_loadings] = QR_algorithm2(Y,sl,el,ru)

%% Calculate covariences of Y at different lags
K = size(Y,1);
N= size(Y,2);
Y = Y - diag(mean(Y,2))*ones(size(Y));
lags = el-sl+1;
M = zeros(K,K*lags);
m=1;
for l = sl  : el
   
        cov_y = (1/(N-l))*(Y(:,1:end-l)*Y(:,l+1:end)');
        M(:,(((m-1)*K)+1):(m*K))  =M(:,(((m-1)*K)+1):(m*K))+cov_y;
        m=m+1;
end

%% Estimation

if nargin == 4
    [Q_fin,~,~,rank] = rrqr(M,'H1',N,ru);
else
    [Q_fin,~,~,rank] = rrqr(M,'H1',N);
end
model_order = rank;
Factor_loadings = Q_fin(:,1:model_order);

return 