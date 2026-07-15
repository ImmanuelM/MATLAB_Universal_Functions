%funciton coded by Immanuel Manohar (idmanohar@crimson.ua.edu)

function [X,Z] = simplex_balancedtransportation(fname)

load(fname)
X = zeros(length(a), length(b));

eps = 10^-5;
%% Implementing northwestcorner rule to get Initial BFS.
col = 1;
row = 1;
a_temp = a;
b_temp = b;
while ((col <= length(b)) && (row <= length(a)))
    X(row,col) = min(a_temp(row),b_temp(col));
    rem = a_temp(row)-b_temp(col);
    if rem > 0 
        col = col +1;
        a_temp(row) = rem;
    elseif rem < 0
        row = row +1;
        b_temp(col) = -rem;
    else
        if ((col <= length(b)) && (row <= length(a)))
        row = row+1;
        X(row,col) = eps;
        col = col+1;
        end
    end
end
display('Initial BFS obtained using North West Corner Rule:')
X = X(1:length(a), 1: length(b))
  
%%  
%  a
%  b

%computing cost: 
Iteration = 0;
while (1)
        Iteration = Iteration +1;
%          size(C)
%          size(X)
    Cost_1 = C.*(X > 0);

    u = ones(size(b))*NaN;
    v = ones(size(a))*NaN;
    v(end) = 0;

    idx = find(X>0);
    [I,J] = ind2sub(size(C),idx);
%     o = 0;
%     while (o < 3)
        for i = length(I) : -1 : 1

            if isnan(u(J(i)))
                u(J(i)) = -v(I(i))+C(I(i),J(i));
            elseif isnan(v(I(i)))
                v(I(i)) = -u(J(i))+C(I(i),J(i));
            end
        end
%         o = o+1;
%     end

%      u
%      v
    display(sprintf('The %d tableau: ',Iteration))
    Tableau = [Cost_1 v'; u 0]

    Relative_cost =    C - (diag(v)*ones(size(C)) + ones(size(C))*diag(u))
    R = Relative_cost;


        if sum(sum(R<0))  == 0
            display( ' Optimal Solution Reached')
            Z = sum(sum(Cost_1.*X));
            return
        else
            idx = find( R == min(min((R))));
            [i,j] = ind2sub(size(C),idx(1));
            theta = min([X(i,:),X(:,j)']);
            [x_new] = cycle(X,i,j,X>0,R);


            X = x_new;
        end
end
        
        

    
    
        
    
    


