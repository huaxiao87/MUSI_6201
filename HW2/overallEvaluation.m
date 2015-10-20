%deltaTime  : a float in millisecond
%funcName   : a string, specify the name of the function 
function [averagePrecision,averageRecall, averageFMeasure] = overallEvaluation(windowSize, hopSize, deltaTime, funcName)

%initialization

%where is the groundTruth?
groundTruthDir      = 'ODB/ODB/ground truth';

%where is the audio data?
audioDir            = 'ODB/ODB/audio'; 


groundTruthFileList = dir(groundTruthDir);
audioList           = dir(audioDir);
precision           = 0;
recall              = 0;
fmeasure            = 0;

%calculates the statistical evaluation measures
for i=3:length(audioList)-1
    
    %load the groudtruth file
    theTextFile     = textscan(fopen([groundTruthDir,'/',groundTruthFileList(i).name]),'%f');
    annotation      = theTextFile{1};
    
	%load the wave file

    [testSig,fs]    = audioread([audioDir,'/',audioList(i+1).name]);  %<-----Here's the problem
    %[x,fs] = audioread();
    
    %load the function to detect onsets
    func            = str2func(funcName);
    
    %evaluate the function
    nvt             = func(testSig, windowSize, hopSize);
    detectedOnsets  = myOnsetDetection(nvt, fs, windowSize, hopSize);
    [P,R,F]         = evaluateOnsets(detectedOnsets,annotation,deltaTime);
    %sum up the value of the three varibles for the fmeasure
    precision   = precision + P;
    recall      = recall + R;
    fmeasure    = fmeasure + F;
end
 
%calculates the average evaluation
averagePrecision    = precision / length(audioList);
averageRecall       = recall / length(audioList);
averageFMeasure     = fmeasure / length(audioList);
end
