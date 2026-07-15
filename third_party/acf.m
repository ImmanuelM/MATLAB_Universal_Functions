% COMPUTES THE ONE-SIDED ACF UPTO A SPECIFIED NUMBER OF LAGS AND PLOTS THE ACF
% (OPTIONAL)
%
% INPUTS:   
%           x: Sequence whose ACF needs to be calculated
%           L: Number of lags upto which ACF needs to be calculated
%           plotopt: Option = 1 (YES, Default), 0 (NO Plot)
%                    Error limits for a white-noise hypothesis are also
%                    plotted
%
% OUTPUTS:
%           acfval: (L+1) Values of ACF (first value at lag zero is unity);
%
% Usage:    acfval = acf(x,lags,plotopt);
%
% Arun K. Tangirala
% 12-10-2006
%

function acfval = acf(x,L,plotopt);


if (nargin == 2)
    plotopt = 1;
end

x = x(:);

% Compute the ACF
[c,lags] = xcov(x,L,'coeff');

% Assign the values of ACF
acfval = c(L+1:end);

% Plot the ACF depending on the option
if (plotopt == 1),
    figure
    stem((0:L),acfval,'linewidth',2);
    hold on
    plot((0:L),acfval,'o','markerfacecolor','red');
    % Plot the error limits for a white-noise assumption
    errlim = 2/sqrt(length(x));
    plot((0:L),ones(L+1,1)*errlim,'r--');
    plot((0:L),-ones(L+1,1)*errlim,'g--');
    grid
    title('Auto-correlation function','fontsize',14,'fontweight','bold');
    ylabel('ACF','fontsize',14,'fontweight','bold');
    xlabel('Lags','fontsize',14,'fontweight','bold');
    set(gca,'Fontsize',12,'Fontweight','bold');
end

    
    