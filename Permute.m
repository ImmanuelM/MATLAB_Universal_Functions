function [ P ] = Permute( i, j ,n)
% [P] = Permute(i,j,n) 
%  Generates a permutation matrix P by interchanging ith and jth row of an
%  identity matrix of size nxn
P = eye(n,n);
t1 = P(:,i);
P(:,i) = P(:,j);
P(:,j) = t1;
end

