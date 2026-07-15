function FE = fe(a,b)
[N,T] = size(a);
err1 = ((1/N)*sum((a-b).^2)).^0.5;
    FE = mean(err1);

end