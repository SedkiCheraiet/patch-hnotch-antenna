clear all;
clc;
%%
%---------------------------------
% INPUT DATA (Problem Definition)
%---------------------------------

% Frequency [Hz]
centralFrequency = 2.4E9;
% Target imput impedence [Ohm]
referenceImpedance = 50;
% Substrate Relative Permittivity
epsilonR = 4.2;
% Substrate Thickness [m]
substrateThickness = 1.52E-3;
% Substrate Measure [m]
substrateWidth = 50E-3;
substrateLength = 50E-3;
% Coaxial Relative Permittivity
coaxialEpsR = 2.2;
% Coaxial Thickness and Inner Diameter and Height [m]
coaxInnerD = 1.04E-3;
coaxHeight = 5E-3;

%--------------------
% Physical constants
%--------------------

% Speed of light [m/s]
c0 = physconst('lightspeed');
% Free space impedance [Ohm]
eta = 120 * pi;

%--------------------------
% Derived Pharameters
%--------------------------

% Free space wavelenght
lambda = c0 / centralFrequency;

%%

%--------------------------
% Execution Phase
%--------------------------

% Calculate width
width = c0/(2*centralFrequency)*sqrt(2/(epsilonR+1));

epsilon_eff = ((epsilonR+1)/2)+((epsilonR-1)/2)*(1+12*substrateThickness/width)^(-1/2);

% Calculate length
length_eff = c0/(2*centralFrequency*sqrt(epsilon_eff));
deltal = 0.412*substrateThickness*(epsilon_eff+0.3)*(width/substrateThickness+0.264)*...
    1/((epsilon_eff-0.258)*(width/substrateThickness+0.8));
length = length_eff - 2*deltal;

% Wave number
wavenumber = 2 * pi / lambda;

% Calculate offset
offsetY = width / 2;
offsetYMATLAB = width/2-offsetY;

offsetX = (length/pi)*acos(sqrt(referenceImpedance*2*pi*width/(eta*lambda))*...
    (1-((wavenumber*substrateThickness)^2)/24));
offsetXMATLAB = -(length/2-offsetX);


% Coaxial cable Outer Diameter
coaxOuterD = coaxInnerD*exp((2*pi*referenceImpedance*sqrt(coaxialEpsR))/eta)/2;


% Calculate notch
notchLength = 1E-4*length/2*(0.001699*epsilonR^7 +...
    0.13761*epsilonR^6 - 6.1782*epsilonR^5 + ...
    93.187*epsilonR^4 - 682.69*epsilonR^3 + ...
    2561.9*epsilonR^2 - 4043*epsilonR + 6697)*1.45;

A = (referenceImpedance/60)*sqrt((epsilonR+1)/2)+...
    (epsilonR-1)/(epsilonR+1)*(0.23+0.11/epsilonR);
B = 377*pi/(2*referenceImpedance*sqrt(epsilonR));

notchWidth = substrateThickness*(8*exp(A)/(exp(2*A)-2));

if notchWidth>2*substrateThickness
    notchWidth = substrateThickness*(2/pi*(B-1-log(2*B-1)+(epsilonR-1)/...
        (2*epsilonR)*(log(B-1)+0.39-0.61/epsilonR)));
end

notchWidth = notchWidth*1.45;

% Compute correction

alpha = 2.3/2.4;
length_corr = length*alpha;
notchLength_corr = notchLength*alpha;

%----------------------------------------------------------------------
% OUTPUT PHASE
%======================================================================
fprintf('-------------------------------------------------------------\n');
fprintf('H notch Probe-Fed Patch Antenna Report\n');
fprintf('-------------------------------------------------------------\n');
fprintf('Input:\n');
fprintf(' Central Frequency \t\t\tf = %.4E [Hz]\n', centralFrequency);
fprintf(' Substrate Permittivity \t\tepsilon_r = %.2E \n', epsilonR);
fprintf(' Substrate Measure \t\t\tlength & width = %.2E [m]\n', substrateLength);
fprintf(' Substrate Thickness \t\t\tthickness = %.2E [m]\n', substrateThickness);
fprintf(' Ref. Impedence \t\t\tZ_0 = %.4E [Ohm]\n', referenceImpedance);
fprintf('\n');
fprintf('Output:\n');
fprintf(' Patch Length \t\t\t\tL = %.4E [m]\n', length);
fprintf(' Effective Patch Length \t\tL_eff = %.4E [m]\n', length_eff);
fprintf(' (Fringe effect length) \t\tdeltaL = %.4E [m]\n', deltal);
fprintf(' Patch Width \t\t\t\tW = %.4E [m]\n', width);
fprintf(' Notch Length \t\t\t\tL_n = %.4E [m]\n', notchLength);
fprintf(' Notch Width \t\t\t\tW_n = %.4E [m]\n', notchWidth);
fprintf(' Feed position x \t\t\ttd_x = %.4E [m]\n', offsetX);
fprintf(' Feed position x MATLAB \t\ttd_x = %.4E [m]\n', offsetXMATLAB);
fprintf(' Feed position y \t\t\ttd_y = %.4E [m]\n', offsetY);
fprintf(' Feed position y MATLAB \t\ttd_y = %.4E [m]\n', offsetYMATLAB);
fprintf(' Coaxial cable diameter  \t\tDout = %.4E [m]\n', coaxOuterD);
fprintf(' Correction alpha \t\t\talpha = %.4E \n', alpha);
fprintf('\n');
fprintf('\n');
fprintf(' Patch Length correct by alpha \t\tL = %.4E [m]\n', length_corr);
fprintf(' Notch Length correction by alpha \tL_n = %.4E [m]\n', notchLength_corr);
fprintf('\n');
fprintf('\n');



