%A     ->  vector valued time series of the form A = [a1, a2,... aN]
% where ak is a K-dimensional time series till time N
%A_ref -> vector valued time series of the form A_ref = [ar1, ar2,... arN]
% where ak is a K-dimensional time series till time N

%Difference b/w A and Ak is that both are almost same with permutaions 
%along with sign changes in rows.

%this function orders the rows and signs accordingly.
%[A1,perm] = ordering(A,A_ref)
%A1 -> ordered rows
%perm -> the permutation matrix multiplied by the sign change required.
function [A1,perm] = ordering(A,A_ref)

corr = A*A_ref';
mx = max(abs(corr),[],2);
cmp = (abs(corr) == diag(mx)*ones(size(corr)));
s = sign(cmp.*corr);
perm = s';
A1 = perm*A;

return