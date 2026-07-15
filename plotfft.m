
function [freq, X] = plotfft(x,fs)
x = x(:);
N = length(x);
X = fft(x);
freq = fs*0.5*linspace(0,1, floor(N/2));

figure()
plot(freq , abs(X(1:floor(N/2))));

figure()
plot(freq , angle(X(1:floor(N/2))));

X = abs(X(1:floor(N/2)));

return