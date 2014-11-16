function [ matchedSignal ] = dtwFilter( concatTestSignal, concatSignals, allSignalNames )
% Description of Matching Algorithm:
% 
% 
% input inputAudio - the normalized audio input in the time domain
%                    that we are comparing to bank
% input audioBank  - an matrix with X the normalized pre-recorded audio
%                    inputs in the time domain
% input audioName  - an array of string correlating to the word of the
%                    pre-recorded audio
% output matchedSignal - the string of the word that is matched
disp('Begin processing data...');
tic;


len = length(concatSignals(1,:));


% initialize values 
finalIndex = 1;

% Analyze first signal
preRec = concatSignals(:,1);
minDist = dtw(concatTestSignal, preRec, 20);

% loop through all the the other signals and compare to previous analysis
for i = 2:len
    preRec = concatSignals(:,i);
    newDist = dtw(concatTestSignal, preRec, 20);
    
    if newDist < minDist
        minDist = newDist;
        finalIndex = i;
    end
    i = i + 1;
end



matchedSignal = concatSignals(:,finalIndex);


time = toc;
fprintf('\nYou said "%s"\n', allSignalNames{finalIndex});
fprintf('It took %f seconds to calculate\n\n', time);


end

