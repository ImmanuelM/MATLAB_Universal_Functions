% function to count the number of zerocrossings in ACF

function [Z] = Zero_crossing_counter(y)
y = y(:);
idx = y > 0;
%idx2 = [1; idx];
Z = sum(abs(idx(1:end-1)-idx(2:end)));

return