%% Standard evaluation metrics 
% [precision, recall, fmeasure] = evaluateOnsets(onsetTimeInSec, annotation, deltaTime)
% intput:
%   onsetTimeInSec: n by 1 float vector, detected onset time in second
%   annotation: m by 1 float vector, annotated onset time in second
%   deltaTime: float, maximum time difference for a true positive (millisecond) 
% output:
%   precision: float, fraction of TP from all detected onsets
%   recall: float, fraction of TP from all reference onsets
%   fmeasure: float, the combination of precision and recall

function [precision, recall, fmeasure] = evaluateOnsets(onsetTimeInSec, annotation, deltaTime)
% initialization
truePositive    = 0;
falseNegative   = length(annotation);
detectedOnsets  = length(onsetTimeInSec);
dTime           = deltaTime/1000;

%count the truePositive
%for each element in onsetTimeInSec, check if there exists any element in
%annotation that is within the tolerance range(deltaTime). If so, then
%the number of truePositive increase by 1
for i = 1:length(onsetTimeInSec)
   for j= 1:length(annotation)
    if annotation(j) < onsetTimeInSec(i)+dTime && annotation(j)> onsetTimeInSec(i)-dTime
        truePositive = truePositive + 1;
        break
    end
   end
end

%count the falseNegative
%for each element in annotation, check if exists any element in onsetTimeInSec 
%(detected onsets) that can cover it with the tolerance. If so, then the
%number of falseNegative decrease by 1
for i = 1:length(annotation)
   for j= 1:length(onsetTimeInSec)
    if annotation(i) < onsetTimeInSec(j)+dTime && annotation(i)> onsetTimeInSec(j)-dTime
        falseNegative = falseNegative - 1;
        break
    end
   end
end

precision       = truePositive / detectedOnsets;
recall          = truePositive / length(annotation);
fmeasure        = 2 * precision * recall / (precision + recall);
end