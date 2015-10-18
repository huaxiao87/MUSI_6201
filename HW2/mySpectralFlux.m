function [ spectralFlux ] = mySpectralFlux( x, windowSize, hopSize )
% computes the spectral flux for onset detection
% number of results
blockNum        = ceil(length(x)/hopSize);

% zero-padding the signal
xAllZeros               = zeros(1,blockNum * hopSize + windowSize - 1);
xAllZeros(1:length(x))  = x;
paddedSignal            = xAllZeros;

% allocate memory
spectrumsOfDividedSignal    = zeros(blockNum,windowSize);
spectralFlux                = zeros(1,blockNum-1);

% divide the signal into blocks
for n = 1:blockNum
	i_start         = (n-1) * hopSize + 1;
	i_stop          = i_start + windowSize - 1;
    spectrumsOfDividedSignal(n, :)   = fft(paddedSignal(i_start:i_stop)); 
end
   difference          = diff(spectrumsOfDividedSignal);
   conjuOfDifference   = conj(difference);
   spectralFlux        = sqrt(sum(difference.*conjuOfDifference))/windowSize;
%     difference          = diff(abs(spectrumsOfDividedSignal));
%     spectralFlux        = sqrt(sum(difference.^2))/windowSize;
end

