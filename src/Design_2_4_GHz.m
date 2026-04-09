%% Antenna Properties 
% Define antenna 
antennaObject = patchMicrostripHnotch;
% Properties changed 
antennaObject.Length = 0.028879;
antennaObject.Width = 0.038734;
antennaObject.NotchLength = 0.01266;
antennaObject.NotchWidth = 0.004362;
antennaObject.Height = 0.00152;
antennaObject.GroundPlaneLength = 0.05;
antennaObject.GroundPlaneWidth = 0.05;
antennaObject.FeedOffset = [-0.0051136 0];
antennaObject.FeedDiameter = 0.0017898;
% Update substrate properties 
antennaObject.Substrate.Name = 'Dieletric';
antennaObject.Substrate.EpsilonR = 4.2;
antennaObject.Substrate.LossTangent = 0;
antennaObject.Substrate.Thickness = 0.00152;

%% Antenna Analysis 
% Define plot frequency 
plotFrequency = 2400000000;
% Define frequency range 
freqRange = (2200:20:2600) * 1e6;
%% show for patchMicrostripHnotch
figure;
show(antennaObject);
%% s11 for patchMicrostripHnotch
figure;
s = sparameters(antennaObject, freqRange); 
rfplot(s);
yline(-10, '--k', 'LineWidth', 1.5);
%% impedance for patchMicrostripHnotch
figure;
impedance(antennaObject, freqRange) 
%% current for patchMicrostripHnotch
figure;
current(antennaObject, plotFrequency) 
%% pattern for patchMicrostripHnotch
figure;
pattern(antennaObject, plotFrequency) 
%% azimuth for patchMicrostripHnotch
figure;
patternAzimuth(antennaObject, plotFrequency,0,'Azimuth',[0:5:360])
%% elevation for patchMicrostripHnotch
figure;
patternElevation(antennaObject, plotFrequency,0,'Elevation',[0:5:360])

