%model order detection - q-yao

function [q,He] = model_order1(y,lags,Q)
[~,~] = size(y);
if nargin == 3
    q = Q;
end
len = size(y,1);
T = size(y,2);
y = y - diag(mean(y,2))*ones(size(y));
M = zeros(len,len);
for i = 1 : lags
       cov_y = (1/(T-i))*(y(:,1:end-i)*y(:,i+1:end)');
       M = M+cov_y*cov_y';
end
%M= M/(T-lags-1);
[U,S,~] = svd(M);
%[U,d] = sort_mat(U,diag(S));
d = diag(S);
if nargin == 2
lam = d(1:20)./d(2:21);
[~,q] = max(lam);
end

He = U(:,1:q);
return