function [model_order, Factor_loadings] = merc(X,Q)


if nargin == 2
    qe=Q;
end

[N,T] = size(X);
[U,S] = eig(1/T*(X*X'));
[U,d] = sort_mat(U,diag(S));

if N>20
    ratio = d(1:20)./d(2:21);
else
    ratio = d(1:end-2)./d(2:end-1);
end

[~,qe] = max(ratio);

He = U(:,1:qe);
model_order = qe;
Factor_loadings = He;