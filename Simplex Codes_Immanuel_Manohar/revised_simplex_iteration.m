%Function coded by Immanuel Manohar (idmanohar@crimnson.ua.edu)

%Performs Revised simplex iterations
function [A_return, b_return, basic_variables,y, flag] = ...
    revised_simplex_iteration(A,b,c,basic_variables)
flag = 1;
b = b(:);
c= c(:)';
basic_variables = basic_variables(:)';
D = (basic_variables == 0);
CD = c(D==1);
CB = c(basic_variables==1);
B = A(:,basic_variables==1);
AD = A(:,D);
y = CB*(B^-1);
RD = CD - y*AD;
a0_bar = B^-1*b;
Iteration = 1;

basic_row = round(zeros(size(basic_variables)));
basic_row(basic_variables ==1) = round(sum(diag(1 : size(B,2))*B)); %stores which row has the non-zero component in the basis matrix B.

display('Initial Tableau:')
basics = find(basic_variables==1);
non_basics = find(D==1);
Tableau = [basics(:) B^-1  a0_bar(:)]

while (Iteration < 20)
    
    if sum(RD<0) == 0
        display('All relative cost coeffitients > 0, optimal solution reached')
        A_return = (B^-1)*A;
        b_return = a0_bar;
        
        return
    else
        [~,ID] = min(RD);
        pivot_column = non_basics(ID(1));
       % AD = A(:,D);
        
        aq = A(:,pivot_column);
        aq_bar = (B^-1)*aq; %aq  interms of current basis
        
        if sum(aq_bar > 0) == 0
            display('The problem is unbounded')
            A_return = A;
            b_return = b;
            flag = 0;
            return
        else
            ratio = a0_bar./aq_bar;
            [~,Id] = min((ratio > 0).*ratio + (ratio <= 0).*Inf);
            pivot_row = Id(1);
            fprintf('Pivot Row: %d; Pivot Column: %d \n',pivot_row,pivot_column)
            
            column_replace = find(basic_row == pivot_row);
            
            
            basic_variables(column_replace) = 0; 
            basic_variables(pivot_column) = 1; 
            basic_row(column_replace) = 0;
            basic_row(pivot_column) = pivot_row;

            B = A(:,basic_variables==1);
            
            D = (basic_variables == 0);
            fprintf('%d Tableau:', Iteration)
            AD = A(:,D);
            basics = find(basic_variables==1);
            non_basics = find(D==1);
            
            a0_bar = B^-1*b;
            Tableau = [basics(:) B^-1  a0_bar(:)]
            Iteration = Iteration +1;
            CD = c(D==1);
            CB = c(basic_variables==1);
            y = CB*(B^-1);
            RD = CD - y*AD;
        end
    end
end