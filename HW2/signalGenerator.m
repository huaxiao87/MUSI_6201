function [ signal ] = signalGenerator( samplingRate, startTimeInSeconds, endTimeInSeconds, frequencyInHerz, amplitude )
% Generate signal by using samplingRate, startTimeInSeconds, endTimeInSeconds, frequencyInHerz and amplitude
t = samplingRate * startTimeInSeconds:(samplingRate * endTimeInSeconds - 1);
signal = amplitude * sin(frequencyInHerz * 2* pi * t / samplingRate);
end