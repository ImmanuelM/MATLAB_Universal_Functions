%Generating Generalised Gaussian pdf

function R = gengauss(m,n,alp,bet)

R  = zeros(m,n);

%%

x = (-3:0.0001:3)';
f = (bet/(2*alp*gamma(1/bet))).*exp(-((abs(x).^bet)./(alp^bet)));
sig = alp+2;
 g = (1/sig*sqrt(2*pi))*exp(-(1/2)*(x./sig).^2);
c = max(f./g);
 %figure(1)
 %plot(x,f,'rx');
 %hold
 %plot(x,g,'bo');
 %plot(x,c.*g,'g');
 %hold

%%
R = accrejrnd(f,g,c,m,n,x,sig);
%figure(2)
% [N,X] = hist(R,70);
%  plot(X,N./max(N),'bo');
%  hold;
%  bet = 2;
%  alp= 1;
% f = (bet/(2*alp*gamma(1/bet))).*exp(-((abs(X).^bet)./(alp^bet)));
% plot(X,(0.9.*f)./max(f),'r');
%  bet = 1;
%  alp= 1;
%  f = (bet/(2*alp*gamma(1/bet))).*exp(-((abs(X).^bet)./(alp^bet)));
%  plot(X,f./max(f),'b');
hold





return



function X = accrejrnd(f,g,c,m,n,x,sig)
               
X = zeros(m,n); % Preallocate memory
res = (1/abs(x(1)-x(2)));
parfor i = 1:m*n
    accept = false;
    while accept == false
        u = rand();
        v = sig*res*randn();
        h = ceil(v)/res;
        [a,b]=max(((h-(2/res))<=x)&(x<=(h+(2/res))));
        if (c*u <= f(b)/g(b) && a~=0)
           X(i) = v/res;
           accept = true;
        end
    end
end