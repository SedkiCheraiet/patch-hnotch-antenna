clear all;
clc;
%% Input Data

% Frequency [Hz]
centralFrequency = 2.4E9;
% Frequency range
freqrange = (2200:20:2600) * 1E6;
% S11 bandwidth threshold [dB]
bandwidthThreshold = -10;

%% Set Parameters

% H shaped Parametric Analysis
% -----------------------------------
% Set min factor
minFactor = 0.05;

% Set max factor
maxFactor = 0.05;

% Number of steps
numStepsSweep = 5;

%% Set Boundaries

antennaObject = resetAntenna();

patchLength = antennaObject.Length;
patchWidth = antennaObject.Width;
notchLength = antennaObject.NotchLength;
notchWidth = antennaObject.NotchWidth;

% Compute boundaries
minLength = patchLength - patchLength * minFactor;
maxLength = patchLength + patchLength * maxFactor;
minWidth = patchWidth - patchWidth * minFactor;
maxWidth = patchWidth + patchWidth * maxFactor;
minNotchLength = notchLength - notchLength * minFactor;
maxNotchLength = notchLength + notchLength * maxFactor;
minNotchWidth = notchWidth - notchWidth * minFactor;
maxNotchWidth = notchWidth + notchWidth * maxFactor;

% Create sweep
lengthSweep = linspace(minLength, maxLength, numStepsSweep);
widthSweep = linspace(minWidth, maxWidth, numStepsSweep);
notchLenghtSweep = linspace(minNotchLength, maxNotchLength, numStepsSweep);
notchWidthSweep = linspace(minNotchWidth, maxNotchWidth, numStepsSweep);

% Allocate resonance freq vector
resonanceFreq = zeros(1, length(lengthSweep));

% Allocate factor vector
fact = zeros(1, length(lengthSweep));


%% Analysis Patch Length 

antennaObject = resetAntenna();

fprintf('Resonance Frequency for Analysis of Length: \n');

figure
for i = 1:numStepsSweep
    pLen = lengthSweep(i);
    antennaObject.Length = pLen;
    
    s = sparameters(antennaObject, freqrange);
    hline = rfplot(s);
    fact(i) = pLen / patchLength;
    hline.DisplayName = sprintf('Factor scale = %.3f', fact(i));
    hold on
    
    s11 = mag2db(abs(rfparam(s,1,1)));
    [s11Min, s11MinIndex] = min(s11);
    resonanceFreq(i) = freqrange(s11MinIndex);
    fprintf(' factor %.3f', fact(i));
    fprintf(' \tf = %.2E [m]\n', resonanceFreq(i));
end
hold off
ylabel('Magnitude dB (S_{11})');
yline(-10, '--k', 'LineWidth', 1.5);
title('S - Parameters Analysis Patch Length');


%% Analysis Patch Width

antennaObject = resetAntenna();

fprintf('Resonance Frequency for Analysis of Width: \n');

figure
for i = 1:numStepsSweep
    pWid = widthSweep(i);
    antennaObject.Width = pWid;
    
    s = sparameters(antennaObject, freqrange);
    hline = rfplot(s);
    fact(i) = pWid / patchWidth;
    hline.DisplayName = sprintf('Factor scale = %.3f', fact(i));
    hold on
    
    s11 = mag2db(abs(rfparam(s,1,1)));
    [s11Min, s11MinIndex] = min(s11);
    resonanceFreq(i) = freqrange(s11MinIndex);
    fprintf(' factor %.3f', fact(i));
    fprintf(' \tf = %.2E [m]\n', resonanceFreq(i));
end
hold off
ylabel('Magnitude dB (S_{11})');
yline(-10, '--k', 'LineWidth', 1.5);
title('S - Parameters Analysis Patch Width');


%% Analysis notchLength

antennaObject = resetAntenna();

fprintf('Resonance Frequency for Analysis of notchLength: \n');

figure
for i = 1:numStepsSweep
    notLen = notchLenghtSweep(i);
    antennaObject.NotchLength = notLen;
    
    s = sparameters(antennaObject, freqrange);
    hline = rfplot(s);
    fact(i) = notLen / notchLength;
    hline.DisplayName = sprintf('Factor scale = %.3f', fact(i));
    hold on
    
    s11 = mag2db(abs(rfparam(s,1,1)));
    [s11Min, s11MinIndex] = min(s11);
    resonanceFreq(i) = freqrange(s11MinIndex);
    fprintf(' factor %.3f', fact(i));
    fprintf(' \tf = %.2E [m]\n', resonanceFreq(i));
end
hold off
ylabel('Magnitude dB (S_{11})');
yline(-10, '--k', 'LineWidth', 1.5);
title('S - Parameters Analysis notchLength');


%% Analysis notchWidth

antennaObject = resetAntenna();

fprintf('Resonance Frequency for Analysis of notchWidth: \n');

figure
for i = 1:numStepsSweep
    notWid = notchWidthSweep(i);
    antennaObject.NotchWidth = notWid;
    
    s = sparameters(antennaObject, freqrange);
    hline = rfplot(s);
    fact(i) = notWid / notchWidth;
    hline.DisplayName = sprintf('Factor scale = %.3f', fact(i));
    hold on
    
    s11 = mag2db(abs(rfparam(s,1,1)));
    [s11Min, s11MinIndex] = min(s11);
    resonanceFreq(i) = freqrange(s11MinIndex);
    fprintf(' factor %.3f', fact(i));
    fprintf(' \tf = %.2E [m]\n', resonanceFreq(i));
end
hold off
ylabel('Magnitude dB (S_{11})');
yline(-10, '--k', 'LineWidth', 1.5);
title('S - Parameters Analysis notchWidth');


