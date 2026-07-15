%[U_sort,S_sort]=sort_mat(U,S,order),
%Coded by: Immanuel Manohar
%Universal Functions
%sorts S in descending/ascending order and interchanges the corresponding columns in
%the matrix U. 
%eg: 
%A = [1,2,3;2,3,4;3,4,5];
% A =
% 
%      1     2     3
%      2     3     4
%      3     4     5
% 
% S =
%
%     3     1     2
%
% [U,S_new] = sort_mat(A,S,'descend')
% 
% U =
% 
%      1     3     2
%      2     4     3
%      3     5     4
%
% S_new =
%
%      3     2     1



function [U_sort,S_sort]=sort_mat(U,S,str)
Ref = abs(S(:)');
S_sort = sort(Ref,str);
%U = U(:)';
U_sort = zeros(size(U));
k=1;
while (k <= size(Ref,2))
    
    j = find(S_sort(k) == Ref) ;

    if size(j,2) > 1
        for l = 1 : size(j,2)
            U_sort(:,k)=U(:,j(l));
            k = k+1;
        end
    else
            U_sort(:,k) = U(:,j);
            k = k+1;
    end
    if k > size(Ref,2)
        break;
    end

end
end
