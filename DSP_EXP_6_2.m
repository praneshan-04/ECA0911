clc;
clear;
close all;

%% Signal
n = 0:79;
x = sin(2*pi*n/40);

%% Quantization
q = 8;

% Truncation
xt = floor(x*q)/q;

% Rounding
xr = round(x*q)/q;

% Quantization Error
et = x - xt;
er = x - xr;

%% Figure 1: Original vs Quantized
figure;
plot(n, x, 'b', n, xr, 'r', 'LineWidth', 1.5);
grid on;
title('Original vs Quantized');
xlabel('Sample Number');
ylabel('Amplitude');
legend('Original', 'Quantized');

%% Figure 2: Truncation vs Rounding
figure;
plot(n, x, 'b', n, xt, 'r', n, xr, 'g', 'LineWidth', 1.5);
grid on;
title('Truncation vs Rounding');
xlabel('Sample Number');
ylabel('Amplitude');
legend('Original', 'Truncated', 'Rounded');

%% Figure 3: Quantization Error
figure;
stem(n, et, 'r');
hold on;
stem(n, er, 'g');
grid on;
title('Quantization Error');
xlabel('Sample Number');
ylabel('Error');
legend('Truncation', 'Rounding');

%% Figure 4: MSE Comparison
figure;

mse_truncation = mean(et.^2);
mse_rounding = mean(er.^2);

bar([mse_truncation mse_rounding]);

set(gca, 'XTick', 1:2);
set(gca, 'XTickLabel', {'Truncation', 'Rounding'});

grid on;
title('MSE Comparison');
ylabel('MSE');
