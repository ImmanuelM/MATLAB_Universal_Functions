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


function [Q,R,Perm,rank] = rrqr_old(A,mode,N,ru,ran)

[n,h] = size(A);
%if nargout == 4
%    mode = 'G1';
%end

if nargin >= 4
    rank_ulim = ru;
else
    rank_ulim = n-1;
end

switch mode
    
    case 'G1'
        [~,Ra] = qr(A);
        Perm = eye(h);
        l = 1;
       while (l <= rank_ulim)
            Rl = Ra(l:n,l:h);
            [~,piv] = max(sum(Rl.^2));
            Ra = Ra*Permute(l,piv(1)+l-1,h);
            Perm = Perm*Permute(l,piv(1)+l-1,h);
            [~,Ra] = qr(Ra);
            l= l+1;
       end
if nargin < 5       
%       D = sum(Ra.^2,2);
        D = abs(diag(Ra));
       epsilon =D(1)/sqrt(n*N);
       D = D+epsilon;
       [~,rank] = max( abs(D(1:rank_ulim-1))./ abs(D(2: rank_ulim)));
       
else
       rank = ran;
end
       A_t = A*Perm;
       [Q,R ] = qr(A_t);
    case 'C2'
        
    case 'GKS1'
        
    case 'S2'
        
    case 'H1'
    [~,Ra] = qr(A);
    if nargin < 5
    [~,Rb,Perm,rank] = rrqr(Ra,'G1',N,ru);
    else
        Perm = eye(h);
        rank = ran;
        Rb = Ra;
    end
    permuted = 1;
    l = 0 ;     %iteration count
    while (permuted == 1)
        permuted = 0;
        l = l + 1;
        % Golub - I step
        R_G = Rb(rank:n,rank:h);
        piv1 = find(sum(R_G.^2)==max(sum(R_G.^2)));
        if piv1 ~= 1
            permuted = 1;
            P = Permute(rank,(piv1(1)+rank-1),h);
            Perm = Perm*P;
            Rb = Rb*P;
            [~,Rb]  = qr(Rb);
        end
        % Stewart - II step
        R_S = Rb(1:rank,1:rank);
        R_Si = (R_S^-1).';
        piv2 = find(sum(R_Si.^2)==max(sum(R_Si.^2)));
        if piv2 ~= rank
            permuted = 1;
            P = Permute(rank,piv2(1),h);
            Perm = Perm*P;
            Rb = Rb*P;
            [~,Rb] = qr(Rb);
        end
        
    end
    A_t = A * Perm;
    [Q,R] = qr(A_t);
    
    case 'H2'
        
    otherwise
        error('use mode as either G1,C1, GKS1, S2,H1 or H2');
        
end




return