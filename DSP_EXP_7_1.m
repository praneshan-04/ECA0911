clc;
clear;
close all;

%% Sampling Parameters
fs = 1000;
t = (0:999)/fs;

%% Original Signal
s = sin(2*pi*100*t) + 0.5*sin(2*pi*200*t);

%% Add Gaussian Noise
n = 0.3 * randn(size(t));

%% Noisy Signal
x = s + n;

%% Figure 1: Signal with Noise
figure;
plot(t, x);
grid on;
title('Signal with Noise');
xlabel('Time (s)');
ylabel('Amplitude');

%% Figure 2: PSD using Periodogram
figure;
periodogram(x, [], [], fs);
title('PSD using Periodogram');

%% Figure 3: Magnitude Spectrum
figure;

X = abs(fft(x));
f = (0:length(X)-1) * fs / length(X);

plot(f(1:500), X(1:500), 'LineWidth', 1.2);
grid on;
title('Magnitude Spectrum');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

%% Figure 4: Power Comparison
figure;

signal_power = mean(s.^2);
noise_power = var(n);

bar([signal_power noise_power]);

set(gca, 'XTick', 1:2);
set(gca, 'XTickLabel', {'Signal', 'Noise'});

title('Power Comparison');
ylabel('Power');
grid on;
