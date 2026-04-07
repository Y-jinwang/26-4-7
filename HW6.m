% Amplification Factor |Z|/y0 vs frequency ratio
clear; clc; close all;

zeta_list  = [0.02,  0.25,   0.5];
line_style = {'-', '--', ':'};   
line_width = [1.5,   2,      2.5];
r = linspace(0, 3, 600);

figure('Color','w'); hold on; grid on;

for i = 1:3
    zeta = zeta_list(i);
    ls   = line_style{i};
    lw   = line_width(i);
    
    D = (r.^2) ./ sqrt((1-r.^2).^2 + (2*zeta*r).^2);
    plot(r, D, 'b', 'LineStyle', ls, 'LineWidth', lw, ...
         'DisplayName', sprintf('\\zeta=%.2f', zeta));
end

xlabel('Frequency ratio r = \omega/\omega_n');
ylabel('Amplification factor |Z|/y_0');
title('Frequency Response of Accelerometer');
legend('Location','best');
xlim([0 3]);