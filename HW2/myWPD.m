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
% computes the spectral flux for onset detection
% number of results
blockNum        = ceil(length(x)/hopSize);

% zero-padding the signal
xAllZeros               = zeros(1,blockNum * hopSize + windowSize - 1);
xAllZeros(1:length(x))  = x;
paddedSignal            = xAllZeros;

% allocate memory
phaseOfDividedSignal    = zeros(blockNum,windowSize);
nvt                     = zeros(1,blockNum-1);

% divide the signal into blocks
for n = 1:blockNum
	i_start                         = (n-1) * hopSize + 1;
	i_stop                          = i_start + windowSize - 1;
    spectrumOfDividedSignal(n, :)   = fft(paddedSignal(i_start:i_stop));
    phaseOfDividedSignal            = angle(spectrumOfDividedSignal); 
    
end

    difference              = diff(phaseOfDividedSignal);
    secondOrderDifference   = unwrap(diff(difference));
    for i=1:blockNum-2
        nvt(i)              = sum(abs(phaseOfDividedSignal(i,:).*spectrumOfDividedSignal(i,:)))/windowSize;
    end
                         
end

