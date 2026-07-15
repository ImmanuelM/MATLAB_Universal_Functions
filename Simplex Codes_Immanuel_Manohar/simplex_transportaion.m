function [X,Z] = simplex_transportaion(fname)

load(fname);

if sum(a) < sum(b)
    display('infeasible as demands cannot be met with the sources');
elseif sum(a) == sum(b)
    [X,Z] = simplex_balancedtransportation(name);
elseif sum(a) > sum(b)
    if  (isempty(S) == 1) || (sum(S ~= 0) == 0)
    %create a single dummy demand node
    new_demand = sum(a) - sum(b);
    b = [b new_demand];
    C = [ C  zeros(size(C,1),1)];
    else 
    %create a single dummy demand node 
    new_demand = sum(a) - sum(b);
    b = [b new_demand];
    mm = min(S);
    C = [ C  ones(size(C,1),1).*mm(1)];
    end
    save(name,'C','a','b','S','Type','name');
    [X,Z] = simplex_balancedtransportation(name);
end


