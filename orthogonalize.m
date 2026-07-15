function [return_A] = orthogonalize(A,a)
a = a./norm(a,2);
corr = A'*a;
corr = corr';
% size(corr)
% size(a)
% size(A)
A_rec = kron(corr,a);
return_A = A-A_rec;
return