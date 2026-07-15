function RMSE = rmse(a,b)
[N,T] = size(a);
err = a-b;
RMSE = mean(mean(err.^2))^0.5;


end