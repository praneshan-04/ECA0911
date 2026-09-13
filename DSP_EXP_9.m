clc;
clear;
close all;

%% Input Signal
x = randn(1,1000);

%% Echo Signal
d = filter([0.8 0.5 0.3], 1, x);

%% LMS Parameters
mu_lms = 0.01;
M = 3;

w_lms = zeros(M,1);
e_lms = zeros(1,length(x));

%% LMS Algorithm
for n = M:length(x)

    x_vec = x(n:-1:n-M+1)';

    y = w_lms' * x_vec;

    e_lms(n) = d(n) - y;

    w_lms = w_lms + mu_lms * e_lms(n) * x_vec;

end

%% NLMS Parameters
mu_nlms = 0.5;
epsilon = 1e-6;

w_nlms = zeros(M,1);
e_nlms = zeros(1,length(x));

%% NLMS Algorithm
for n = M:length(x)

    x_vec = x(n:-1:n-M+1)';

    y = w_nlms' * x_vec;

    e_nlms(n) = d(n) - y;

    norm_x = x_vec' * x_vec + epsilon;

    w_nlms = w_nlms + ...
        (mu_nlms / norm_x) * e_nlms(n) * x_vec;

end

%% Figure 1: Input and Echo Signal
figure;

plot(x, 'b', 'LineWidth', 1.2);
hold on;
plot(d, 'r', 'LineWidth', 1.2);

grid on;
legend('Input', 'Echo');

title('Input and Echo Signal');
xlabel('Sample Number');
ylabel('Amplitude');

%% Figure 2: LMS Output
figure;

plot(e_lms, 'LineWidth', 1.2);

grid on;
title('LMS Output');
xlabel('Sample Number');
ylabel('Error');

%% Figure 3: NLMS Output
figure;

plot(e_nlms, 'LineWidth', 1.2);

grid on;
title('NLMS Output');
xlabel('Sample Number');
ylabel('Error');

%% Figure 4: MSE Comparison
figure;

mse_lms = movmean(e_lms.^2, 50);
mse_nlms = movmean(e_nlms.^2, 50);

semilogy(mse_lms, 'r', 'LineWidth', 1.5);
hold on;
semilogy(mse_nlms, 'b', 'LineWidth', 1.5);

grid on;
legend('LMS', 'NLMS');

title('MSE Comparison');
xlabel('Sample Number');
ylabel('Mean Squared Error');
