%% onset detection with adaptive thresholding
% [onsetTimeInSec] = myOnsetDetection(nvt, fs, windowSize, hopSize)
% input: 
%   x: N by 1 float vector, input signal
%   fs: float, sampling frequency in Hz
%   windowSize: int, number of samples per block
%   hopSize: int, number of samples per hop
% output: 
%   onsetTimeInSec: n by 1 float vector, onset time in second

function [onsetTimeInSec] = myOnsetDetection(nvt, fs, windowSize, hopSize)

% YOUR CODE HERE: 
thres = myMedianThres(nvt, 25, 50);
[pks, locs] = findpeaks(nvt);
n = length(locs);
onsetNum = [];

for i = 1:n
    if pks(i) >= thres(locs(i))
        onsetNum = [onsetNum;locs(i)];
    end
end

onsetTimeInSec = (onsetNum - 1) * hopSize / fs;

