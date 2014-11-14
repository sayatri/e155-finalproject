function [ matchedSignal ] = filterTemplate( inputAudio, audioBank, audioName )
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



% Displays the results on the screen
disp('The result of the filter is ...')
disp(matchedSignal)

end

