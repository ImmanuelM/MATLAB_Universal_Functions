%RRQR based on column correlation

function [Q,R] = rrqr_new(A,num_rank)
A_new = A;
Perm = eye(size(A,2));

for i = 1 : num_rank
M = A_new'*A_new;
D = diag(diag(M).^0.5);
R_M = D^(-1)*M*D^(-1);    
[~,pivot] = max(sum(R_M,2));
pivot
P = Permute(i,pivot+i-1,size(A,2));
Perm = Perm*P;
A_new = A_new * Perm;
A_new = orthogonalize(A_new,A_new(:,i));
A_new = A_new(:,i:end);
end

[Q,R] = qr(A_new);

return