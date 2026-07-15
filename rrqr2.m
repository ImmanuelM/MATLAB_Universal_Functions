%rrqr FACTORIZATION
%function [Q,R] = rrqr(A,mode)
%A -> matrix to decompose
%mode-> either G1,C1, GKS1, S2,H1, H2
%where,
% G1r -> Golub-I returns numerical rank based on threshold
% G1  -> rank not specified
% C2 -> Chan-I
% S2 -> Stewart-II
% H1 -> Hybrid-I
% H2 -> Hybrid-II

%ref: Chandrasekaran, Shivkumar, and Ilse CF Ipsen.
%"On rank-revealing factorisations." 
%SIAM Journal on Matrix Analysis and Applications 15.2 (1994): 592-622.

%code by: Immanuel.M (IIT Madras)

function [Q_final,rank] = rrqr2(A,avno,ru)
[~,~,Perm,rank] = rrqr(A,'H1',ru);
A_new = A*Perm;
[n,~] = size(A);
Q_bulk = zeros(n,avno*rank);
for i = 1 : avno
    [Qs,~,Perm,~] = rrqr(A_new,'H1',ru,rank);
 %   size(Q_bulk(:,(((i-1)*rank)+1):i*rank))
 %   size(Qs(:,1:rank))
    Q_bulk(:,(((i-1)*rank)+1):i*rank) = Qs(:,1:rank);    
    A_sort = A_new * Perm;
    A_new = A_sort(:,rank+1:end);
end
[Q,~] = rrqr(Q_bulk,'H1',ru,rank);
Q_final = Q(:,1:rank);



return