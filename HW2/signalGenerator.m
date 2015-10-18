function [ signal ] = signalGenerator( samplingRate, startTimeInSeconds, endTimeInSeconds, frequencyInHerz, amplitude )
t = samplingRate * startTimeInSeconds:(samplingRate * endTimeInSeconds - 1);
signal = amplitude * sin(frequencyInHerz * 2* pi * t / samplingRate);
end