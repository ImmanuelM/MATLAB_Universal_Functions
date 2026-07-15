%********************************************************************************
%Function coded by Immanuel Manohar (idmanohar@crimson.ua.edu)
%*********************************************************************************
%function designed for solving standard linear programming problems:
%solves the three types of problems  (1. Standard Linear programming,
%2. Transportaion and 3. Transshipment) using 7 differnt algorithms. Details are given below:
%
%The funciton could be called simply as: 
%simplex(Type) where Type is 1 / 2 / 3 based on above. 
%
%or if you want to use a .mat file with preentered values,
%
%simplex(Type,'file_name') In this the Type does not matter and will be
%overwritten from the file if present. 
%
% This function returns a saved matfile with the olutions.
% The solutions are in variables X ->  The optimal solution if
% exists, else returns all possible Basic feasible solutions or returns NA
% if  infeasible. 
% Z -> the optimal cost if exists or gives NA. 
%
%
%Type 1:
%standard linear program:
%min c'x
%st Ax = b
% x >=0. 
%
%solvers:
%  'TPS' : two phase simplex
%  'Revised' : Revised simplex 
%  'DS': Dual simplex algorithm
%  'PD': Primal Dual Algorithm
%
%Type 2:
%network flow problem using graphs. 
% C = cost of flow between nodes.
% bi = outflow - inflow at each node i.
% bi >0 for source node,
% bi < 0  for sink and 
% bi = 0 for relay nodes. 
%
%Type 3:
% Transportation problem
% C = cost of flow between nodes.
% a: quantity at source
% b: demand
% S: storage costs if any.

function  simplex(Type,varargin)
clc;
if isempty(varargin)== 1
switch Type
    case 1
        reenter =1;
        while reenter == 1
        disp('You are trying to solve a standard Linear Program')
        disp('Enter the input parametrs')
        disp('-------------------------')
        c = input('Enter the cost values,c: ');
        c = c(:)';
        A = input('Enter the constraint matrix A: ');
        b = input('Enter the right side of the constraint equation, b: ');
        b= b(:);
        solver = input('Enter solver to be used:\\n (TP- Two phase simplex), (Revised - Revised Simplex), (DS - Dual Simplex),\\n (PD - Primal Dual Algorithm), Your Choice: ','s');
        disp('Input parameters are entered')
        disp('----------------------------')
        disp(sprintf('solution to be found using %s:',solver)); 
        disp('The cost c is given by: '); 
        c
        disp('The constraint matrix A:'); 
        A
        disp('The right side of the constraint equation: b'); 
        b
        store = input('confirm above and store values? (1 = yes, 0 = no)');
        if store ==1 
            name1 = input('enter file name to store as:' ,'s');
            name = sprintf('%s.mat',name1);
            save(name,'c','A','b','Type','solver','name');
            reenter = 0;
            [X,Z,D] = simplex1(name);
            disp('-------------------------')
            disp ('The optimal basic feasible solution(s) is: ')
            X
            disp('-------------------------')
            disp (sprintf('The optimal cost is Z : %d',Z));
            Z
            disp('The dual is: ')
            D
            fprintf('---------(Results are also stored in the file name: %s)----------------',name)
            save(name,'c','A','b','Type','solver','X','Z','name');
        else
            reenter =1;
        end
        end
    case 2
        reenter = 1;
        while reenter == 1
            disp('You are trying to solve a transportation problem')
        disp('Enter the input parametrs')
        disp('-------------------------')
        C = input('Enter the cost matrix,c: ');
        a = input('Enter the source quantities: ');
        b = input('Enter the destination quantities: ');
        S = input('Enter the storage cost (if any): ');

        disp('Input parameters are entered')
        disp('----------------------------')
        disp('solution to be found using Array format of simplex based on northwest corner rule'); 
        disp('The cost c is given by: '); 
        C
        disp('The source quantities is given by:'); 
        a
        disp('The Destination quantities is given by:'); 
        b
        disp('The Storage cost is given by:')
        S
        store = input('confirm above and store values? (1 = yes, 0 = no)');
        if store ==1 
            name1 = input('enter file name to store as:','s');
            name = sprintf('%s.mat',name1);
            save(name,'C','a','b','S','Type','name');
            reenter = 0;
            [X,Z] = simplex_transportaion(name);
            disp('-------------------------')
            disp ('The optimal basic feasible solution(s) is: ')
            X
            disp('-------------------------')
            disp (sprintf('The optimal cost is Z : %d',Z));
            Z
            fprintf('---------(Results are also stored in the file name: %s)----------------',name)
            save(name,'C','a','b','S','Type','X','Z','name');
        else 
            reenter = 1;
        end
        end
    case 3
        reenter = 1;
        while reenter == 1
        disp('You are trying to solve a network flow problem')
        disp('Enter the input parametrs')
        disp('-------------------------')
        C = input('Enter the cost matrix,c: ');
        b = input('Enter b, the node demand: ');
        

        disp('Input parameters are entered')
        disp('----------------------------')
        disp('solution to be found using Network format for Simplex'); 
        disp('The cost c is given by:'); 
        C
        disp('Demands of each node is given by:'); 
        b
        
        store = input('confirm above and store values?');
        if store ==1 
            name1 = input('enter file name to store as:','s');
            name = sprintf('%s.mat',name1);
            save(name,'C','b','Type','name');
            reenter = 0;
            [X,Z] = simplex_network(name);
            disp('-------------------------')
            disp ('The optimal basic feasible solution(s) is: ')
            X
            disp('-------------------------')
            disp (sprintf('The optimal cost is Z : %d',Z));
            Z
            fprintf('---------(Results are also stored in the file name: %s)----------------',name)
            save(name,'C','b','Type','X','Z','name');
        end
        end
    otherwise
        error('Enter a valid Type (1/2/3)')
        
end

else
    fname = varargin{1}
    load(fname);
    
    switch Type
        case 1
             [X,Z,D] = simplex1(name);
            disp('-------------------------')
            disp ('The optimal basic feasible solution(s) is: ')
            X
            disp('-------------------------')
            disp (sprintf('The optimal cost is Z : %d',Z));
            Z
            disp('The dual is: ')
            D
            fprintf('---------(Results are also stored in the file name: %s)----------------',name)
            save(name,'c','A','b','Type','solver','X','Z','name');
        case 2
            [X,Z] = simplex_transportaion(name);
            disp('-------------------------')
            disp ('The optimal basic feasible solution(s) is: ')
            X
            disp('-------------------------')
            disp (sprintf('The optimal cost is Z : %d',Z));
            Z
            fprintf('---------(Results are also stored in the file name: %s)----------------',name)
            save(name,'C','a','b','Type','X','Z','name');
        case 3
            [X,Z] = simplex_network(name);
            disp('-------------------------')
            disp ('The optimal basic feasible solution(s) is: ')
            X
            disp('-------------------------')
            disp (sprintf('The optimal cost is Z : %d',Z));
            Z
            fprintf('---------(Results are also stored in the file name: %s)----------------',name)
            save(name,'c','b','Type','X','Z','name');
        otherwise
            error('The type in file does not exist');
    end
    
end

