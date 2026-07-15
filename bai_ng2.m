%Universal Functions _ bai_ng_2
%Written by Immanuel Manohar
%Implementation of paper "Determining the number of factors in Approximate
%factor models" by Jushan Bai and Serena Ng-Econometrica, Vol 70, No. 1

%This code gives the principal components for the matrix X(dimension NxT)as 
%X=He*Fe +E where He is the uncorrelated factor loading matrix of
%dimension qexN and 'qe' is the model order and the dimension after 
%reduction using PCA and 'Fe' are the factors with 'E' being attributed to 
%noise.


function [qe,He,Fe,U]=bai_ng2(X,Q)
if nargin == 2
    qe=Q;
end

[N,T] = size(X);
[U,S] = eig(1/T*(X*X'));
[U,d] = sort_mat(U,diag(S));
flag = false;
if nargin==1
k = 1;
F_k = U(:,1:k);
e_k = X - F_k*F_k'*X;
error(k) = log((N^-1)*(T^-1)*norm(e_k,'fro')^2)+...
    k*((N+T)/(N*T))*log((N*T)/(N+T));
while (flag == false)&&(k < N)
    k = k+1;
    F_k = U(:,1:k);

e_k = X - F_k*F_k'*X;
error(k) = log((N^-1)*(T^-1)*norm(e_k,'fro')^2)+...
    k*((N+T)/(N*T))*log((N*T)/(N+T));

flag = error(k)>error(k-1);
end
if (k == N)&&(flag == false) 
    qe = N;
else
qe = k-1;
end
end
He = U(:,1:qe);
Fe = He'*X;

return