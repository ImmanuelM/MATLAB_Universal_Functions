function [model_order,Factor_loadings] = QR_algorithm3(Y,sl,el,ru)

%% Calculate covariences of Y at different lags
K = size(Y,1);
N= size(Y,2);
% Defining M=[Ryy(1) Ryy(2)... Ryy(m)]
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
    [Q_fin,rank] = rrqr2(M,40,ru);
else
    [Q_fin,rank] = rrqr2(M,20,N-1);
end
%display('et2');
model_order = rank;
Factor_loadings = Q_fin(:,1:model_order);

%  factors = Factor_loadings'*Y;
% % 
%  [~,~,He,~] = model_order1(factors,lags,model_order);
%  Factor_loadings = Factor_loadings*He;

return 