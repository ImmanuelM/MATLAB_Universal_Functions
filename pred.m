function y_pred=pred(y,AR_coeff,h_step)
y = y(:)';
AR_coeff = AR_coeff(:);
T = length(y);
yp = zeros(h_step+1,T);
Lags = length(AR_coeff);
yp(1,:) = y;
for i = 1 : h_step
yh = shift_mat(yp(i,:),1,Lags-1,'lin');
yp(i+1,:) = (-AR_coeff(2:end)')*yh;
end

y_pred = yp(h_step+1,:);
y_pred = y_pred(:);