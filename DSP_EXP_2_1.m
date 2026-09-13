clc;
clear;
close all;

% ===============================
% Chebyshev Type-I Low-Pass Filter
% ===============================

Wp = 0.4;       % Passband Frequency (normalized)
Ws = 0.55;      % Stopband Frequency (normalized)
Rp = 1;         % Passband Ripple (dB)
As = 40;        % Stopband Attenuation (dB)

% Calculate minimum filter order and cutoff frequency
[N, Wn] = cheb1ord(Wp, Ws, Rp, As);

% Design Chebyshev Type-I Low-Pass Filter
[b, a] = cheby1(N, Rp, Wn, 'low');

% ===============================
% Display Filter Parameters
% ===============================

fprintf('Filter Order = %d\n', N);
fprintf('Cutoff Frequency = %.4f * pi rad/sample\n', Wn);

% ===============================
% Stability Check
% ===============================

if all(abs(roots(a)) < 1)
    disp('System is STABLE');
else
    disp('System is UNSTABLE');
end

% ===============================
% Magnitude & Phase Response
% ===============================

figure;
freqz(b, a);
title('Magnitude and Phase Response');

% ===============================
% Impulse Response
% ===============================

figure;
impz(b, a);
grid on;
title('Impulse Response');

% ===============================
% Group Delay
% ===============================

figure;
grpdelay(b, a);
grid on;
title('Group Delay');

% ===============================
% Pole-Zero Plot
% ===============================

figure;
zplane(b, a);
grid on;
title('Pole-Zero Plot');
