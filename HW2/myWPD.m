%% Novelty function: weighted phase deviation
% Paper : S. Dixon, 2006, onset detection revisited 
% [nvt] = myWPD(x, windowSize, hopSize)
% input: 
%   x: N by 1 float vector, input signal
%   windowSize: int, number of samples per block
%   hopSize: int, number of samples per hop
% output: 
%   nvt: m by 1 float vector, the resulting novelty function 

function [nvt] = myWPD(x, windowSize, hopSize)

% YOUR CODE HERE: 
stftMatrix = spectrogram(x, windowSize, windowSize - hopSize);
numBlocks = size(stftMatrix, 2);
angleMatrix = unwrap(angle(stftMatrix));
nvt = mean(abs(stftMatrix(:, 3:numBlocks).* diff(angleMatrix, 2, 2)));
nvt = nvt';

% unwrap...
