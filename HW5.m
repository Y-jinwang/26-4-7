clear; clc; close all;
omega_ratio_list = [0.5, 1, 5];    % 频率比 ω/ωn
zeta_list = [0.02, 0.05, 0.1];     % 阻尼比 ζ
A = 1;                             % 振幅
count = 0;                         % 子图计数器
figure('Color','w','Position',[100,100,1000,800]);
for i = 1:length(omega_ratio_list)
    omega_ratio = omega_ratio_list(i);  % ω/ωn
    for j = 1:length(zeta_list)
        zeta = zeta_list(j);
        count = count + 1;
      
        t = linspace(0, 2*pi / omega_ratio, 1000);
        x = A * sin(omega_ratio * t);
        F = sin(omega_ratio * t) + 2 * zeta * omega_ratio * cos(omega_ratio * t);
    
        subplot(3, 3, count);
        plot(x, F, 'b-', 'LineWidth', 1.5);
        hold on;
        
        plot([-1, 1], [-1, 1], 'k--', 'LineWidth', 1.5);
        
        grid on;
        axis equal;
        xlabel('x');
        ylabel('\itF');
        title(sprintf('ω/ω_n=%.1f, ζ=%.2f', omega_ratio, zeta));
        hold off;
    end
end

sgtitle('Force-Displacement Relationship Curve');