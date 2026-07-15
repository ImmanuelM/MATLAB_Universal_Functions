function [MA_coeff,sig,gamma] = MA_recursive(y,MA_order)
MA_coeff = zeros(1,MA_order);
sig = zeros(1,MA_order);
gamma = zeros(1,MA_order);
for m = 1 : MA_order
    Cq = mean(y(1:end-m+1).*y(m:end).^2);
    Cq2 = mean((y(1:end-m+1).^2).*y(m:end));
    rq = mean(y(1:end-m+1).*y(m:end));
    MA_coeff(m) = Cq/Cq2;
    sig(m) = rq*Cq2/Cq;
    gamma(m) = (Cq2^2)/Cq;
end
end