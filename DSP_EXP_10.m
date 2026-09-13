clc;
clear;
close all;

%% Sampling Parameters
Fs = 8000;
t = 0:1/Fs:3;

%% Clean Signal
x = sin(2*pi*200*t) + 0.5*sin(2*pi*400*t);

%% Noisy Signal
noise = 0.3 * randn(size(x));
xn = x + noise;

%% Spectral Subtraction
Y = fft(xn);

% Estimate noise spectrum
N = fft(noise);

% Magnitude and phase of noisy signal
Y_mag = abs(Y);
Y_phase = angle(Y);

% Spectral subtraction
X_mag = max(Y_mag - abs(N), 0);

% Enhanced signal
xe = real(ifft(X_mag .* exp(1j*Y_phase)));

%% Time-Domain Signals
figure;

subplot(3,1,1);
plot(t, x);
title('Clean Speech');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

subplot(3,1,2);
plot(t, xn);
title('Noisy Speech');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

subplot(3,1,3);
plot(t, xe);
title('Enhanced Speech');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

%% Spectrograms
figure;

subplot(3,1,1);
spectrogram(x, 256, 128, 256, Fs, 'yaxis');
title('Clean Spectrogram');

subplot(3,1,2);
spectrogram(xn, 256, 128, 256, Fs, 'yaxis');
title('Noisy Spectrogram');

subplot(3,1,3);
spectrogram(xe, 256, 128, 256, Fs, 'yaxis');
title('Enhanced Spectrogram');

%% Magnitude Spectra
Nfft = length(x);

f = (0:Nfft/2-1) * Fs/Nfft;

X_clean = abs(fft(x));
X_noisy = abs(fft(xn));
X_enhanced = abs(fft(xe));

figure;

subplot(3,1,1);
plot(f, X_clean(1:Nfft/2));
title('Clean Spectrum');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;

subplot(3,1,2);
plot(f, X_noisy(1:Nfft/2));
title('Noisy Spectrum');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;

subplot(3,1,3);
plot(f, X_enhanced(1:Nfft/2));
title('Enhanced Spectrum');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;
