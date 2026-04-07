clear; clc; close all;
% 参数
varpi = linspace(0, 3, 1000); 
zeta_all = [0.1, 0.2, 0.3, 0.5, 0.7, 1.0];
color_list = ["b","r","g","m","c","k"];
name_list = {'\zeta=0.1','\zeta=0.2','\zeta=0.3','\zeta=0.5','\zeta=0.7','\zeta=1.0'};
figure('Position', [100, 100, 800, 500])
hold on; 
grid on;
box off;              
ax = gca;
ax.TickDir = 'in';   
ax.LineWidth = 0.8;   
%设置范围
x_lim = [0, 3];
y_lim = [0, 6];
xlim(x_lim); 
ylim(y_lim);
%上框线和右框线
line([x_lim(2), x_lim(2)], y_lim, 'Color', 'k', 'LineWidth', ax.LineWidth, 'HandleVisibility', 'off'); 
line(x_lim, [y_lim(2), y_lim(2)], 'Color', 'k', 'LineWidth', ax.LineWidth, 'HandleVisibility', 'off'); 
%字体
set(ax, 'FontName','Times New Roman', 'FontSize',10);
xlabel('Frequency ratio \omega/\omega_n', 'FontSize',12);
ylabel('A.F.', 'FontSize',12);
title('放大因子曲线', 'FontName','SimSun', 'FontSize',14, 'FontWeight','bold');
% 绘制曲线
for i = 1:length(zeta_all)
    z = zeta_all(i);
    AF = 1 ./ sqrt( (1 - varpi.^2).^2 + (2*z*varpi).^2 ); 
    plot(varpi, AF, 'Color', color_list(i), 'LineWidth', 1.5, 'DisplayName', name_list{i});
end

legend('Location','northeast', 'FontSize',10);
hold off;