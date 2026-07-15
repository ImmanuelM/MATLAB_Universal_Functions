%Code by Immanuel Manohar (idmanohar@crimson.ua.edu)

function [X,Z,D] = Revised_simplex(fname)
load(fname)

n = size(A,2);
fprintf('Number of optimization variables: %d \n', n )
m = size(A,1);
fprintf('Number of basic variables: %d \n', m )

%% Phase - I finding the initial basic feasible solution

% creating new A with dummy variables
b= b(:);
c = c(:)';
A_new = [A eye(size(A,1))];

c_new = [zeros(1,size(A,2)) ones(1,size(A,1))];

% b remains unaltered. 
% simplex_iteration with new A and cost to obtain initial BFS.
basic_variables = zeros(1,size(A_new,2));  
basic_variables(size(A,2)+1:end)= ones(1,size(A,1)); %the dummy variables form the initial basic feasible solution in Phase I.  
disp('Phase I to determine initial basic feasible solution ')
[A_return, b_return,basic_variables,~,flag_new] = revised_simplex_iteration(A_new,b,c_new,basic_variables);
if flag_new == 0
    X = 'NA';
    Z = 'NA';
else 
    disp('Phase II to determine optimal basic feasible solution ')
    A_refined = (A_return(1:size(A,1), 1: size(A,2)));
    b_refined = b_return;
    c_refined = c;
    basic_variables = basic_variables(1:size(A,2));
    [A, b,basic_variables,D,flag_new] = revised_simplex_iteration(A_refined,b_refined,c_refined,basic_variables);
    if flag_new == 0
        X = 'NA';
        Z = 'NA';
        
    else
        % Find columns of A that are basic. 
        X = zeros(1,size(A,2));
        for i = 1 : size(A,2)
            if basic_variables(i) == 1
                X(i) = b(A(:,i) == 1);
            end
        end
        Z = c_refined*X(:);
        disp('****************************************************** ')
        display(sprintf(' The optimal solution is given by: X : %s \n',num2str(X)))
        display(sprintf(' The optimal objective value is given by: Z : %d \n',Z))
        disp('******************************************************')
        
    end
end