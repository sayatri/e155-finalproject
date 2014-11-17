%function [ matchedSignal ] = xcorrFilter( concatTestAudio, concatSignals, allSignalNames )

% Description of Matching Algorithm:
% 
% Use cross-correlation to match audio signals
% 
% input concatTestAudio - the normalized audio input in the time domain
%                    that we are comparing to bank
% input concatSignals  - an matrix with X the normalized pre-recorded audio
%                    inputs in the time domain
% input allSignalNames  - an array of string correlating to the word of the
%                    pre-recorded audio
% output matchedSignal - the string of the word that is matched

concatTestAudio = windowSignal(Dog);
concatSignals = windowSignal(allSignals);

disp('Begin processing data...');
tic;

len = length(concatSignals(1,:));

% setting up extended signals
matZero = zeros(len,5000);
extTestAudio = zeros(5000,1);
extSignals = zeros(5000, len);

extTestAudio(1:2000) = concatTestAudio';
extSignals(1:2000,:) = concatSignals;

fftTest = fft(extTestAudio);

for i = 1:len
     fftCurrent = fft(extSignals(:,i));
     fftCurrent = fliplr(fftCurrent);
     fftxCorr = fftTest.*fftCurrent;
     xCorr(:,i) = ifft(fftxCorr);
end

plotAll(xCorr, allSignalNames)
suptitle('Result of X-Correlation');
    

% Displays the results on the screen
%fprintf('\nYou said "%s"\n', allSignalNames{finalIndex});
fprintf('It took %f seconds to calculate\n\n', time);


%end

