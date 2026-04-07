clear; clc; close all;

%参数
wn = 10;
Xs = 1; 
x0 = 3;
t = linspace(0, 2, 1000); 

%待定系数
C1 = x0;                  
C2 = Xs / 2; 
A = - (wn * Xs) / 2;
xh = C1 * cos(wn * t) + C2 * sin(wn * t);  %通解
xp = A * t .* cos(wn * t);              %特解
x_total = xh + xp;                  %总位移

env_up = C1 + abs(A) * t;
env_down = -C1 - abs(A) * t;

%绘图
figure('Position', [200, 200, 800, 500], 'Name', 'HW2_2');
plot(t, x_total, 'b', 'LineWidth', 1.2); hold on;
plot(t, env_up, 'r--', 'LineWidth', 1);   % Upper envelope
plot(t, env_down, 'r--', 'LineWidth', 1); % Lower envelope

%注释
title('Resonant Response ($\omega=\omega_n$, Excitation = $\sin\omega_n t$)', 'Interpreter','Latex', 'FontName','Times New Roman', 'FontSize',14);
xlabel('Time $t$ (s)', 'Interpreter','Latex', 'FontName','Times New Roman', 'FontSize',12);
ylabel('Displacement (m)', 'FontName','Times New Roman', 'FontSize',12);
legend('Total Response', 'Amplitude Envelope', 'Location','best', 'FontName','Times New Roman', 'FontSize',10);
grid on; set(gca, 'FontName','Times New Roman');
hold off;

%输出结果
fprintf('齐次待定系数 C1 = %.4f, C2 = %.4f\n', C1, C2);
fprintf('特解系数 A = %.4f\n', A);
fprintf('包络线斜率： %.2f m/s\n', abs(A));
fprintf('x(t) = %.4f*cos(10t) + %.4f*sin(10t) + %.4f*t*cos(10t)\n', C1, C2, A);