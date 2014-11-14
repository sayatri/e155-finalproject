function [ normSignal ] = normalizeSignal( signal )
% Description: Normalized the magnitude of the signal in the time
%              domain. Also removes audio-free signal.
% input signal - audio input in time domain
% output normSignal - normalized signal in the time domain

% get max amplitude from signal
maxAmp = max(abs(signal));

normSignal = signal / maxAmp;  % normalilize amplitude of signal

len = length(signal);
i = 1;
cutoff = 0.01*maxAmp;


% get starting index of shortened signal
while i <= len
    if normSignal(i) > cutoff
        startindex = i;
        break
    else
        continue
    end
end


reverseSignal = fliplf(normSignal);

j = 1;
while j <= len
    if reverseSignal(j) > cutoff
        endindex = j;
        break
    else
        continue
    end
end

normSignal = normSignal(startindex:endindex);


end
