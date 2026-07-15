%Function to plot scalogram using Gabor wavelets
%Author: Immanuel Manohar
%gabor_sca(x,t,bf,fmax)
%x -> input signal
%t -> time axis
%bf -> base Frequency of gabor wavelet (This will be scaled higher and
%lower to obtain the scalogram
%fmax-> maximum frequency of x till which the analysis needs to be done

function gabor_sca(x,t,bf,fmax,W)

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%Gabor-Wavelet%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Nu0 = bf;  %%%%%%%%%%%%%Base Frequency%%%%%%%%%%%%
x = x(:)';
%Nu0 = 100; %S(1:41) = 1./(2.^(0:.01:4));%%%%%%%%%%%%%Scale Values
smax = nextpow2(fmax/Nu0);

S = 1./(2.^(0:.01:smax));
rS = 1./S; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Reciprocal Scale values%%%%%%%%%%%%%%%%%%%
%W= 0.25;%%%%%%%%%%%%%%%%%%%%%%
%Eta = Nu0*W;


for k =1:length(S)
g1(:,k) = ((rS(k)/W).*exp(-pi*((rS(k)/W).*t).^2)).*exp(2*pi*Nu0*1i.*t*rS(k));
end
g2(:,1:length(S))=g1(((length(g1)-1):-1:1),1:length(S));


g(:,1:length(S)) = [g2(:,1:length(S)); g1(:,1:length(S))];
T = [-t(length(t):-1:2),t];

for sca = 1 : length(S)
    
    Y(:,sca)=cconv(x,g(:,sca)',length(g));
end
y = zeros(length(t),length(S));
for sca = 1: length(S)
    a = 1;
    for st = (length(T)+1)/2 : length(T)
        y(a,sca) = (Y(st,sca));
        a = a+1;
    end
end
        
size(y)
y = y';       
freq = Nu0*S.^-1;

imagesc(t,freq,abs(y))
shading flat;
colormap(hot);
ylabel('Frequency in Hz');
xlabel('Time in sec');