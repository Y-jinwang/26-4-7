clear; clc; close all;
%参数
wn = 10;       
w = 2;        
Xs = 1;        
x0 = 3;
t = linspace(0, 5, 1000); 
%待定系数
A = Xs / (1 - (w/wn)^2);
C1 = x0;
C2 = - (A * w) / wn;
xh = C1 * cos(wn * t) + C2 * sin(wn * t);  % 自由振动
xp = A * sin(w * t);                       % 受迫振动
x_total = xh + xp;                         % 总位移

%绘图
figure('Position', [100, 100, 800, 600], 'Name', 'HW2_1');
%自由振动
subplot(3,1,1);
plot(t, xh, 'b', 'LineWidth', 1.2);
title('Free Vibration Component $x_h(t)$', 'Interpreter','Latex', 'FontName','Times New Roman', 'FontSize',12);
xlabel('Time $t$ (s)', 'Interpreter','Latex', 'FontName','Times New Roman', 'FontSize',10);
ylabel('Displacement (m)', 'FontName','Times New Roman', 'FontSize',10);
grid on; set(gca, 'FontName','Times New Roman');

%受迫振动
subplot(3,1,2);
plot(t, xp, 'r', 'LineWidth', 1.2);
title('Forced Vibration Component $x_p(t)$', 'Interpreter','Latex', 'FontName','Times New Roman', 'FontSize',12);
xlabel('Time $t$ (s)', 'Interpreter','Latex', 'FontName','Times New Roman', 'FontSize',10);
ylabel('Displacement (m)', 'FontName','Times New Roman', 'FontSize',10);
grid on; set(gca, 'FontName','Times New Roman');
%总位移
subplot(3,1,3);
plot(t, x_total, 'g', 'LineWidth', 1.2);
title('Total Response $x(t)$', 'Interpreter','Latex', 'FontName','Times New Roman', 'FontSize',12);
xlabel('Time $t$ (s)', 'Interpreter','Latex', 'FontName','Times New Roman', 'FontSize',10);
ylabel('Displacement (m)', 'FontName','Times New Roman', 'FontSize',10);
grid on; set(gca, 'FontName','Times New Roman');
% 输出
fprintf('受迫振动待定系数 A = %.4f \n', A);
fprintf('齐次解待定系数 C1 = %.4f, C2 = %.4f\n', C1, C2);
fprintf('\n最终振动响应方程:\n');
fprintf('x(t) = %.4f*cos(10t) + %.4f*sin(10t) + %.4f*t*cos(2t)\n', C1, C2, A);