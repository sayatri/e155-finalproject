%% Training

%% Cat
recCat = audiorecorder(96000, 24, 1);
disp('Say Cat.')
recordblocking(recCat, 2);
disp('End of Recording.');

% Play back the recording.
play(recCat);

% Store data in double-precision array.
Cat = getaudiodata(recCat);

%% Dog
recDog = audiorecorder(96000, 24, 1);
disp('Say Dog.')
recordblocking(recDog, 2);
disp('End of Recording.');

% Play back the recording.
play(recDog);

% Store data in double-precision array.
Dog = getaudiodata(recDog);

%% Mouse
recMouse = audiorecorder(96000, 24, 1);
disp('Say Mouse.')
recordblocking(recMouse, 2);
disp('End of Recording.');

% Play back the recording.
play(recMouse);

% Store data in double-precision array.
Mouse = getaudiodata(recMouse);

%% Horse
recHorse = audiorecorder(96000, 24, 1);
disp('Say Horse.')
recordblocking(recHorse, 2);
disp('End of Recording.');

% Play back the recording.
play(recHorse);

% Store data in double-precision array.
Horse = getaudiodata(recHorse);


%% New Signal

recSignal = audiorecorder(96000, 24, 1);
disp('Start speaking to test the system.')
recordblocking(recSignal, 2);
disp('End of Recording.');

% Play back the recording.
play(recSignal);

% Store data in double-precision array.
newSignal = getaudiodata(recSignal);


%% Convolution

conv = conv(training, newSignal);


%% Matched Signal Implementation

rawSignal = newSignal(:,1);
inputSignal = normalizeSignal(rawSignal);  %% normalize

% audioBank{1} = Cat;
% audioBank{2} = Dog;
% audioBank{3} = Mouse;
% audioBank{4} = Horse;
audioBank = [Cat Dog Mouse Horse];
audioName = {'Cat' 'Dog' 'Mouse' 'Horse'};

for i=1:4
        comp = audioBank(:,i);
        audioBank(:,i) = normalizeSignal(comp); %% normalize
end

matchedSignal = filterSignal(inputSignal, audioBank, audioName);


%%

% Plot the waveform.
subplot(5,1,1);
plot(Cat);
title('Cat');

subplot(5,1,2);
plot(Dog);
title('Dog');

subplot(5,1,3);
plot(Mouse);
title('Mouse');

subplot(5,1,4);
plot(Horse);
title('Horse');

subplot(5,1,5);
plot(newSignal);
title('newSignal');

%%
spectrogram(Cat)

figure
spectro



