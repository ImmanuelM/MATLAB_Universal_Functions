%B  = shift_mat(C,lag_start,lag_end,type)
%lag_start and lag_end should be greater than or equal to 0.
%two types of shifting: 'lin'(default) or 'circ' representing linear 
%and circular shift
function B  = shift_mat(C,lag_start,lag_end,type)
if nargin == 3
    type = 'lin';
end
C = C(:);
if lag_start < lag_end
B = zeros(length(C),lag_end-lag_start);
k = 1;
else
B = zeros(length(C),lag_start-lag_end);
k = -1;    
end
count = 1;

if strcmp(type, 'circ')
for ll = lag_start :k: lag_end
B(:,count) =  circshift(C,[ll,0]);
count = count+1;
end

elseif strcmp(type,'lin');
    
for ll = lag_start :k: lag_end
B(1:end-ll,count) = C(ll+1:end);
count = count+1;
end

else
    error('type can only be "lin" or "circ"');
end
B = B';

return