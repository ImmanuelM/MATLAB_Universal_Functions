%biased estimation of Auto/Cross Covariance Matrix
%R = cvf_b(u,M,v)
%R -> output Auto/cross correlation matrix,
%u -> input vector (1)
%M -> lags upto which acvf matrix needs to be computed (must specify)
%v -> input vector (2) (optional based on auto/ cross covariance needed)

% code by: Immanuel David Rajan M

function R = acvf_b(u,M,v)
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
        
        R(p,q) = sigxx_b(u,v,(p-q));
        
    end
end
return


%% declaring functions
function sig_xx = sigxx_b(u,v,l)
%introducing delay in v

N = length(u);
vd = zeros(size(v));

if l>0
    vd(l+1:N) = v(1:N-l);
else
    vd(1:N-abs(l)) = v(abs(l)+1:N);
end

sig_xx = 1/length(u)*sum(u'*vd);


return