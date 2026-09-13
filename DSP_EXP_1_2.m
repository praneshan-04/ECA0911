%Matlab code for butterworth Highpass filter

% ===============================
% Butterworth High-Pass Filter
% ===============================

clc;
clear;
close all;

% Filter Specifications
Fs = 8000;          % Sampling Frequency (Hz)
Fp = 1000;          % Passband Frequency (Hz)
Fst = 3000;         % Stopband Frequency (Hz)
Rp = 1;             % Passband Ripple (dB)
Rs = 20;            % Stopband Attenuation (dB)

% Normalize Frequencies
Wp = Fp/(Fs/2);
Ws = Fst/(Fs/2);

% Calculate Minimum Filter Order
[N, Wn] = buttord(Wp, Ws, Rp, Rs);

% Design Butterworth Low-Pass Filter
[b, a] = butter(N, Wn, 'high');

% Display Results
fprintf('Minimum Filter Order (N) = %d\n', N);
fprintf('Cutoff Frequency (Wn) = %.4f\n', Wn);

% Frequency Response
figure;
freqz(b, a);
title('Frequency Response');

% Impulse Response
figure;
impz(b, a, 50);
title('Impulse Response');

% Step Response
figure;
stepz(b, a);
title('Step Response');

% Pole-Zero Plot
figure;
zplane(b, a);
title('Pole-Zero Plot');
