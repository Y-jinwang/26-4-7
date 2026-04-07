clear; clc; close all;

%% ===  (b) & (c)  ===
M = 1;
K = 1;    
C = 0;     
x0 = 1;  
v0 = 0;   

wn = sqrt(K/M);     
Tn = 2*pi/wn;       
t_end = 5*Tn;       

t_exact = 0:0.01:t_end;
x_exact = cos(wn * t_exact);

% ==========================================
figure('Name', 'Figure 1: Stable Steps (0.1 & 0.25)', 'Position', [100 100 750 450]);
hold on;

% exact
plot(t_exact, x_exact, 'k-', 'LineWidth', 2, 'DisplayName', 'Exact: cos(t)');

% dt = 0.1
dt1 = 0.1 * Tn;
t1 = 0:dt1:t_end;
x1 = central_difference(M, C, K, zeros(size(t1)), x0, v0, dt1, t1);
plot(t1, x1, 'b-o', 'LineWidth', 1.2, 'DisplayName', '\Delta t / T_n = 0.1');

% dt = 0.25
dt2 = 0.25 * Tn;
t2 = 0:dt2:t_end;
x2 = central_difference(M, C, K, zeros(size(t2)), x0, v0, dt2, t2);
plot(t2, x2, 'g-o', 'LineWidth', 1.2, 'DisplayName', '\Delta t / T_n = 0.25');

title('Central Difference Method vs Exact Solution (Stable Steps)');
xlabel('Time (s)');
ylabel('Displacement x(t)');
legend('Location', 'bestoutside');
grid on;
ylim([-1.5 1.5]); 

% dt = 0.35
% ==========================================
figure('Name', 'Figure 2: Unstable Step (0.35)', 'Position', [150 150 750 450]);
hold on;

% 绘制精确解
plot(t_exact, x_exact, 'k-', 'LineWidth', 2, 'DisplayName', 'Exact: cos(t)');

% 计算并绘制 dt = 0.35
dt3 = 0.35 * Tn;
t3 = 0:dt3:t_end;
x3 = central_difference(M, C, K, zeros(size(t3)), x0, v0, dt3, t3);
plot(t3, x3, 'r-o', 'LineWidth', 1.2, 'DisplayName', '\Delta t / T_n = 0.35');

title('Central Difference Method vs Exact Solution (Unstable Step)');
xlabel('Time (s)');
ylabel('Displacement x(t)');
legend('Location', 'bestoutside');
grid on;
ylim([-3 3]);


%% === (d) ===
% ==========================================

figure('Name', 'Figure 3: Part d Rectangular Pulse (Multiple Steps)', 'Position', [200 150 900 650]);

zeta = 0.1;                
C2 = 2 * zeta * sqrt(K*M); 

dt_test_ratios = [0.1, 0.25, 0.288, 0.30]; 

for i = 1:length(dt_test_ratios)
    subplot(2, 2, i);
    hold on;
    
    dt_test = dt_test_ratios(i) * Tn;
    t_d = 0:dt_test:6*Tn;
    
    % F(t)
    F_pulse = ones(size(t_d));      
    F_pulse(t_d > 2*Tn) = 0;        
    
    % central_difference
    x_pulse = central_difference(M, C2, K, F_pulse, 0, 0, dt_test, t_d);
    
    x_plot = x_pulse;
    x_plot(abs(x_plot) > 5) = NaN; 
    
    plot(t_d, x_plot, 'b-', 'LineWidth', 1.5, 'DisplayName', 'Response x(t)');
    plot(t_d, F_pulse, 'r--', 'LineWidth', 1.5, 'DisplayName', 'Force F(t)');
    
    title(sprintf('Step: \\Delta t = %g T_n', dt_test_ratios(i)), 'FontWeight', 'bold');
    xlabel('Time (s)');
    ylabel('Amplitude');
    grid on;

    ylim([-2 2.5]); 

    if i == 1
        legend('Location', 'northeast');
    end
end


%% === (a)central_difference ===
function x = central_difference(M, C, K, F, x0, v0, dt, t)
    N = length(t);
    x = zeros(1, N);  
    a0 = (F(1) - C*v0 - K*x0) / M;
    x_minus_1 = x0 - dt*v0 + (dt^2 / 2)*a0;
    K_eff = M/(dt^2) + C/(2*dt);
    coeff_1 = M/(dt^2) - C/(2*dt);
    coeff_2 = K - 2*M/(dt^2);
    %initial
    x(1) = x0;
    x_prev = x_minus_1;
    x_curr = x(1);
    
    for i = 1:N-1
        F_eff = F(i) - coeff_2*x_curr - coeff_1*x_prev;

        x_next = F_eff / K_eff;
        x(i+1) = x_next;

        x_prev = x_curr;
        x_curr = x_next;
    end
end