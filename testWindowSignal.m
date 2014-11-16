% This script tests the windowSignal function
close all
figure
plotAll(allSignals, allSignalNames);
suptitle('Signals Before Windowing');

newSignals = windowSignal(allSignals, allSignalNames);

figure
plotAll(newSignals, allSignalNames);
suptitle('Signals After Windowing');
