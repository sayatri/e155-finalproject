function [ concatSignal ] = windowSignal( allSignals, allSignalNames )
% Takes in an audio signal and windows it to a length
% of 3000 from 10000. Does this by finding the max
% amplitude of the signal and indexing 1000 before and
% 2000 after.

len = length(allSignals(1,:)); % get number of audio

concatSignal = ones(2000, len);

    for i= 1:len
        fprintf('Now concatenating %s\n',  allSignalNames{i})
        
        [~, index] = max(abs(allSignals(:, i)));
        
        if index <= 500
            startIndex = 1;
            endIndex = 2000;
        else 
            startIndex = index - 500;
            endIndex = index + 1499;
        end
        
        concatSignal(:,i) = allSignals(startIndex:endIndex, i);
    end
    
    
end

