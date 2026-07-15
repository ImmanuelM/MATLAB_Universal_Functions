%unbiased estimation of Auto/Cross Covariance Matrix
%R = acvf_ub(u,M,v)
%R -> output Auto/cross correlation matrix,
%u -> input vector (1)
%M -> lags upto which acvf matrix needs to be computed (must specify)
%v -> input vector (2) (optional based on auto/ cross covariance needed)

% code by: Immanuel David Rajan M

function R = cvf_ub(u,M,v)

if nargin == 2
    u = u(:);
    v = u(:);
elseif nargin == 3
        u = u(:);
        v = v(:);
else 
    error('Check input arguements');
end



R = zeros(M);

for p = 1:M
    for q = 1:M
        
        R(p,q) = sigxx_ub(u,v,(p-q));
        
    end
end
return


%% declaring sub functions
function sig_xx = sigxx_ub(u,v,l)
%introducing delay in v

N = length(u);
vd = zeros(size(v));
if l>0
    vd(l+1:N) = v(1:N-l);
else
    vd(1:N-abs(l)) = v(abs(l)+1:N);
end
sig_xx = 1/(length(u)-l)*sum(u'*vd);


return