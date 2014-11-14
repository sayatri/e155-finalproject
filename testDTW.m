

%  load('preRecAudio.mat');

 
audioMat = [Cat Close Dog Horse]; % Mouse Off On Open Pause Start Stop];
audioNam = ['Cat' 'Close' 'Dog' 'Horse']; % 'Mouse' 'Off' 'On' 'Open'...
            %    'Pause' 'Start' 'Stop'];
            

[length, numRec] = size(audioMat);

distMat = zeros(numRec);
distMat = distMat(:,1)


% initial
i = 2;  
finalIndex = 1;

preRecSignal = audioMat(:,1);
disp('Begin processing data...');

minDist = dtw(Dog(40000:80000), preRecSignal(40000:80000), 20);

%%
while i < numRec
    preRecSignal = audioMat(:,i);
    newDist = dtw(Dog(40000:80000), preRecSignal(40000:80000), 100);
    
    if newDist < minDist
        minDist = newDist;
        finalIndex = i;
    end
    
    i = i + 1;
end

time = toc;

fprintf('The final matching audio is %s', audioName(finalIndex));
fprintf('It took this long %f', time);