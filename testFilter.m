%% If you want to record a signal to test

recSignal = audiorecorder(5000, 8, 1);
disp('Start speaking to test the system.')
recordblocking(recSignal, 2);
disp('End of Recording.');

% Play back the recording.
play(recSignal);

% Store data in double-precision array.
newSignal = getaudiodata(recSignal);


%%
% Assign whether or not you want to test a new signal, or signal in the
% audio bank.

testSignal = newSignal;

%%
% concatenate the signals
concatSignal = windowSignal(allSignals);
concatTestSignal = windowSignal(testSignal);

dtwFilter(concatTestSignal, concatSignal, allSignalNames);