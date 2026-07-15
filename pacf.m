% COMPUTES THE PACF UPTO A SPECIFIED NUMBER OF LAGS AND PLOTS THE PACF (OPTIONAL)
%
% INPUTS:   
%           x: Sequence whose PACF needs to be calculated
%           L: Number of lags upto which PACF needs to be calculated
%           plotopt: Option = 1 (YES, Default), 0 (NO Plot)
%                    Error limits for a white-noise hypothesis are also
%                    plotted
%
% OUTPUTS:
%           pacfval: (L+1) Values of ACF (first value at lag zero is unity);
%
% Usage:    pacfval = pacf(x,lags,plotopt);
%
% Arun K. Tangirala
% 17-10-2006
%

function pacfval = pacf(x,L,plotopt);


% Set the default options
switch nargin 
    case 2
        plotopt = 1;
    case 1
        L = 20;
        plotopt = 1;
end

x = x(:);

% Compute the acf values upto L
acfval = acf(x,L,0);
acfval = acfval(2:end);

% Initialize the Phi matrix and set the values at the first lag
phix = acfval(1);
tempphi = phix(1);

% Compute PACF recursively using Durbin's equations
for k = 2:L,
    tempvar1 = sum(tempphi(k-1,1:k-1).*acfval(k-1:-1:1)');
    tempvar2 = sum(tempphi(k-1,1:k-1).*acfval(1:k-1)');
    tempphi(k,k) =  (acfval(k) - tempvar1)/(1 - tempvar2);
    for j = 1:k-1,
        tempphi(k,j) = tempphi(k-1,j) - tempphi(k,k)*tempphi(k-1,k-j);
    end
end

pacfval = [1 ; diag(tempphi)];

% Plot the ACF depending on the option
if (plotopt == 1),
    figure
    plot((0:L),pacfval,'linewidth',2);
    hold on
    plot((0:L),pacfval,'o','markerfacecolor','red');
    % Plot the error limits for a white-noise assumption
    errlim = 2/sqrt(length(x));
    plot((0:L),ones(L+1,1)*errlim,'r--');
    plot((0:L),-ones(L+1,1)*errlim,'g--');
    grid
    title('Partial auto-correlation function','fontsize',14,'fontweight','bold');
    ylabel('PACF','fontsize',14,'fontweight','bold');
    xlabel('Lags','fontsize',14,'fontweight','bold');
    set(gca,'Fontsize',12,'Fontweight','bold');
end

