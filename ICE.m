% Implementation of Incremental Condition Estimation by Christing H. Bischof
% for an upper / lower triangular matrix which is generated one column / 
% row at a time,  respectively, an estimate of the condition number is got
% using the information of the previously estimated condition number and the
% new column / row information. Note implementation whoen here is for lower
% triangular matrix and it can be generalized for the upper triangular
% version.
%
% The function: 
% [kappa, y_max, y_min] = ICE (new_row, x_max, x_min) 
%
% kappa is the new  estimate of the condition number, y_min is the new
% minimum singular vector, y_max is the estimate of the new maximum
% singular vector x_min  is the previous estimate of the minimum singular
% vector, x_max is the estimate of the previous maximum singular vector
% all of the above while assuming unitary singular values.  
% new_row is the new row / column added to the previous lower/ upper
% triangular matrix.


function [kappa, y_max, y_min] = ICE (new_row, x_max, x_min) 
new_row = new_row(:);
x_max = x_max(:);
x_min = x_min(:);

v = new_row(1:end-1);
gamma = new_row(end);



% calculating sigma_min
    alpha = v'*x_min;
    beta = gamma^2*(x_min'*x_min)+alpha^2-1;
    eta = beta/(2*alpha);

if alpha ~= 0 
    
   mu = eta + sign(alpha)*sqrt(eta^2+1);
   cons = 1/sqrt(mu^2+1);
   s = cons*mu;
   c = -cons*-1;
    
else
    if (abs(gamma)*norm(x_min,2))>1
        s = 1;
        c = 0;
        
    else
        s = 0; 
        c = 1;
    end    
end

   y_min = [s.*x_min; ((c-s*alpha)/gamma)];
   
%calculating sigma_max
clear alpha beta eta s c mu;
    alpha = v'*x_max;
    beta = gamma^2*(x_max'*x_max)+alpha^2-1;
    eta = beta/(2*alpha);
    
if alpha ~= 0     
   mu = eta - sign(alpha)*sqrt(eta^2+1);
   cons = 1/sqrt(mu^2+1);
   s = cons*mu;
   c = -cons*-1;    
else
    if (abs(gamma)*norm(x_max,2))>1
        s = 0;
        c = 1;
        
    else
        s = 1; 
        c = 0;
    end    
end
   y_max = [s.*x_max; ((c-s*alpha)/gamma)];   
   
   
   kappa =( norm(y_max,2)/ norm(y_min,2))^-1;
   
return 