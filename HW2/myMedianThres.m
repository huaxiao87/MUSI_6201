%% Adaptive threshold: median filter
% [thres] = myMedianThres(nvt, order, lambda)
% input: 
%   nvt: m by 1 float vector, the novelty function
%   order: int, size of the sliding window in samples
%   lambda: float, a constant coefficient for adjusting the threshold
% output:
%   thres = m by 1 float vector, the adaptive median threshold

function [thres] = myMedianThres(nvt, order, lambda)

% YOUR CODE HERE: 
L = size(nvt,1);
half_order = floor(order/2);
thres = [];

for i = 1:L
    wStart = min(L - order + 1, max(1, i - half_order));    % starting point of median sliding window
    wEnd = wStart + order - 1;    % ending point of median sliding window
    G = lambda + median(nvt(wStart:wEnd));  % threshould
    thres = [thres;G];
end