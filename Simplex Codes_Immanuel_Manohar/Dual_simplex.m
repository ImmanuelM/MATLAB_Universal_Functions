%function coded by Immanuel Manohar (idmanohar@crimson.ua.edu)

%Dual simplex helps avoid phase I of finding an Initial B.F.S. 
%solves 
%min c'*x
%st 
%Ax <= b;
% x>=0;
function [X,Z,flag] = Dual_simplex(fname)
flag = 1;
load(fname)

b = b(:); % converting the b into column matrix b=transpose(b)
[m, n] = size(A); % n -> Number of Primal variables, m -> Number of Dual Variables


eq = 0;
if length(c) < n % length c less than numver of primal variables.
    c = [c zeros(1,n-length(c))]; % Assign zeros to cost of extra primal variables for which cost was not specified
end



A=[A eye(m)]; % adding the identity matrix for whole A
ncol = size(A,2); % length of Matrix A
c = [c zeros(1,ncol-length(c))]; % make the length of c equal to ncol of A
Tableau = [A b; c 0];
subs = ncol+1:ncol+m; % this indicates column number which has identity matrix possess as basic variables

disp(sprintf('\n\n Initial tableau'))
Tableau
A = Tableau;
[bmin, row] = min(b); % to find the min b of RHS in Ax>=b
tbn = 0; % initialize the number of tableau
%Dual-simplex operation% Pivot operation
while ~isempty(bmin) && bmin < 0 && abs(bmin) > eps
    if A(row,1:m+eq+n) >= 0 % checking whether the row particular to negative b is not positive
     disp(sprintf('\n Empty feasible region \n'))
%     varargout(1)={subs(:)}; % if the row is positive , position of the basic variables
%     varargout(2)={A}; % final A value
%     varargout(3) = {zeros(n,1)}; % flush all the basic variables to zeros
%     varargout(4) = {0}; % final cost value set as zero
      X = 'NA'
      Z = 'NA'
      flag = 0;
      
    return
    end
    aa = A(m+1,1:m+n);
    bb = A(row,1:m+n);
    bb1 = bb + (bb == 0).*1;
    [~,col] = max(((aa./bb1).*(bb<0))+(bb>=0).*-10000); %to find the pivot element
    disp(sprintf(' pivot row-> %g pivot column-> %g',row,col))
    subs(row) = col; % the pivot element gets added to basic
    A(row,:)= A(row,:)/A(row,col); % making pivot element equal to 1
    for i = 1:m+eq+1 % Update the tableau
        if i ~= row
        A(i,:)= A(i,:)-A(i,col)*A(row,:); % pivot operation
        end
    end
    tbn = tbn + 1; %update the number of tableau
    disp(sprintf('\n\n Tableau %g',tbn))
    Tableau = A
[bmin, row] = min(A(1:m+eq,m+eq+n+1)); % i.e process of finding pivot column
end
x = zeros(m+n+eq,1); % flushing out the old values stored for the variable x
x(subs) = A(1:m+eq,m+eq+n+1); %% Updating the final basic variable values
x = x(1:n);

z = -A(m+eq+1,n+m+eq+1);
X = x;
Z = z;
% disp(sprintf('\n\n Problem has a finite optimal solution\n\n'))
% disp(sprintf('\n Values of the legitimate variables:\n'))
% for i=1:n
% disp(sprintf(' x(%d)= %f ',i,x(i))) %print the basic variables
% end
% disp(sprintf('\n Objective value at the optimal point:\n'))
% disp(sprintf(' z= %f',z))