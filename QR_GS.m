%function [ Q,R ] = QR_GS( A )
%Returns QR of matrix A using Gram- Schmidt Decomposition Method
%program by - Immanuel Manohar.
function [ Q,R ] = QR_GS( A )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[m,n] = size(A);
Q = zeros(m);
R = zeros(size(A));
for l = 1 : n
    Q(:,l) = A(:,l)-Q(:,1:l-1)*((A(:,l).'*Q(:,1:l-1)).');
    
    R(1:l-1,l) = ((A(:,l)'*Q(:,1:l-1)).');
    R(l,l) = norm(Q(:,l),2);
    Q(:,l) = Q(:,l)/norm(Q(:,l),2);
end

return