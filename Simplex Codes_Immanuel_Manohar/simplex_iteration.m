%Code by Immanuel Manohar (idmanohar@crimson.ua.edu)

function [A_return, b_return, basic_variables,  z, r, flag] = simplex_iteration(A,b,c,basic_variables)
flag = 1;
z = 0;
r = c;
%forming initial tableau:

Tableau = [A b;r 0];

disp('The initial simplex tableau is given by: ') 
Tableau

%Find the columns corresponding to the initial basic feasible solution and
%setting the corresponding cost to zero.
bs_no = 0;
for i = 1: size(A,2) 
  if (norm(A(:,i),1) == norm(A(:,i),Inf)) && (norm(A(:,i),1) == 1)
      %i is a column corresponding to basic feasible solution. 
      bs_no = bs_no+1;
      pivot_column = i;
      pivot_row = A(:,i)== 1;
      
      if r(i) ~= 0
          Tableau(end,:) = Tableau(end,:)-Tableau(pivot_row,:).*r(i);
      end
  end
end

if bs_no ~= size(A,1)
    error('Need initial basic feasible solution to start simplex iteration ');
end

disp(sprintf('The 1st tableau after transforming the last row is: '))
Tableau

Iteration = 1;
while (Iteration < 20)
    r = Tableau(end,1:end-1);
    A = Tableau(1:end-1,1:end-1);
    b = Tableau(1:end-1,end);
    z = -Tableau(end,end);
    if sum(r < 0) == 0
        display('All relative cost coeffitients > 0, optimal solution reached')
        A_return = A;
        b_return = b;
        return
    else
        Iteration = Iteration +1;
        [~,Id] = min(r);
        pivot_column = Id(1); %incase there are multiple r(i) with same minimum value. 
        basic_variables(pivot_column) = 1;
        ratio = b./A(:,pivot_column);
        if sum((ratio >= 0)) ==0
            display('The problem is unbounded')
            A_return = A;
            b_return = b;
            flag = 0;
            return
        end
            
        [~,Id] = min((ratio > 0).*ratio + (ratio <= 0).*Inf);
        pivot_row = Id(1); %incase there are multiple ratios with the same minimum value >0;
        basic_variables(A(pivot_row,:)== 1) = 0;
        fprintf('Pivot Row: %d; Pivot Column: %d \n',pivot_row,pivot_column)
        %pivoting with the found pivot element:
        Tableau(pivot_row,:) = Tableau(pivot_row,:)./Tableau(pivot_row,pivot_column);
        temp = Tableau(pivot_row,:);
        Tableau = Tableau - diag(Tableau(:,pivot_column))*ones(size(Tableau))*diag(temp);
        Tableau(pivot_row,:) = temp;
        disp(sprintf('The %d tableau is: \n', Iteration))
        Tableau
    end
end

