function [averagePrecision,averageRecall, averageFMeasure] = overallEvaluation(deltaTime, funcionName)
%initialization
groundTruthDir      = 'ODB/ODB/ground truth';
audioDir            = 'ODB/ODB/audio'; 
groundTruthFileList = dir(groundTruthDir);
audioList           = dir(audioDir);
precision           = 0;
recall              = 0;
fmeasure            = 0;

%calculates the statistical evaluation measures
for i=3:length(audioList)
    %load the groudtruth file
    annotation      = textscan(groundTruthFileList(i));
    
    %load the function to detect onsets
    func            = str2func(funcName);
    detectedOnsets  = func((audioList(i)));
    
    %evaluate the function
    [P,R,F]     = evaluateOnsets(detectedOnsets,annotation,deltaTime);
    precision   = precision + P;
    recall      = recall + R;
    fmeasure    = fmeasure + F;
end

%calculates the evaluation
averagePrecision    = precision / length(audioList);
averageRecall       = recall / length(audioList);
averageFMeasure     = fmeasure / length(audioList);
end
