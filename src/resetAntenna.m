
function [ra] = resetAntenna ()

% Antenna Properties 

% Define antenna 
ra = patchMicrostripHnotch;
% Properties changed 
ra.Length = 0.028879;
ra.Width = 0.038734;
ra.NotchLength = 0.012659;
ra.NotchWidth = 0.004362;
ra.Height = 0.00152;
ra.GroundPlaneLength = 0.05;
ra.GroundPlaneWidth = 0.05;
ra.FeedOffset = [-0.0051136 0];
ra.FeedDiameter = 0.0017898;
% Update substrate properties 
ra.Substrate.Name = 'Dieletric';
ra.Substrate.EpsilonR = 4.2;
ra.Substrate.LossTangent = 0;
ra.Substrate.Thickness = 0.00152;


end



