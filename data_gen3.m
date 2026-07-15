%data_gen3
% Every time this function is called, it returns a random samples for the
% model r = Hf + e; 
% here f is a ARMA process.

function [r,H,factors,MA_coeff,AR_coeff,error] = data_gen3(no_of_stocks,...
    no_of_days,no_of_factors,AR_order,MA_order,H_orth,H_norm, AR_coeff_giv,...
    MA_coeff_giv) 

r = zeros(no_of_stocks,no_of_days);
H = randn(no_of_stocks,no_of_factors);

if H_orth == 1
H = orth(H);
end

H = H_norm*H;
f = randn(no_of_factors,no_of_days+20000);

if nargin == 7
    AR_coeff = ones(AR_order,no_of_factors);
    root = 2;
    while (root > 0.99) 
        AR_coeff = randn([AR_order,no_of_factors]);
        AR_coeff = AR_coeff ./ (ones(size(AR_coeff))*diag(AR_coeff(1,:)));
        for ll = 1 : no_of_factors
            roota(ll)  = max(abs(roots(AR_coeff(:,ll))));
        end
        root = max(roota);
    end
     
     
    MA_coeff = rand(MA_order,no_of_factors);
    MA_coeff = MA_coeff ./ norm(MA_coeff,'fro');
    MA_coeff(1,:) = ones(1,no_of_factors);


elseif nargin == 9
    AR_coeff = AR_coeff_giv;
    MA_coeff = MA_coeff_giv;
end
error = 1*randn(size(r));
%% 
% adopting an ARMA model to factors, F.
%AR_coeff = diag([1,-0.9])*AR_coeff;
e = randn(1,no_of_days+20000);
for kk = 1 : no_of_factors
%    e = randn(1,no_of_days+20000);
    f(kk,:) = filter(MA_coeff(:,kk),AR_coeff(:,kk),e);
end

factors = f(:,20000+1:end);
r = H*factors + error;

return

