%Code by Immanuel Manohar (idmanohar@crimson.ua.edu)
%selects the algorithm to solve the Stabndard Linear Programming
function [X,Z,D] = simplex1(fname)

load(fname)

switch solver
    case 'TP'
        [X,Z] = Two_phase_simplex(fname);
        D = 'NA';
        
    case 'Revised'
        [X,Z,D] = Revised_simplex(fname);
        
    case 'DS'
%         error('Will be implemented later');
        [X,Z] = Dual_simplex(fname);
        D = 'NA';
    case 'PD'
        error('Will be implemented later');
        %[X,Z,D] = Primal_Dual(fname);
end




