clear; clc; close all;
zeta = 0.1;
Tn = pi;
wn = 2;
wd = wn*sqrt(1-zeta^2);
m = 1;
x0 = 1;
v0 = 0;
t_end = 5*Tn;
td = 2*pi;
dt_list = [pi/10, pi/20, pi/50]; % Δt = π/10, π/20, π/50
dt_labels = {'Δt = π/10', 'Δt = π/20', 'Δt = π/50'};
%% impluse
F_rect = @(t) (t>=0 & t<=td)*1;          
F_tri  = @(t) (t>=0 & t<=td).*(t/(2*pi)); 

free = @(t) exp(-zeta*wn*t).*(x0*cos(wd*t) + (v0+zeta*wn*x0)/wd*sin(wd*t));

%% Rectangular Pulse
figure('Name','Rectangular Pulse','Color','w');
for idx = 1:length(dt_list)
    dt = dt_list(idx);
    t = 0:dt:t_end;
    N = length(t);
    x = zeros(1,N);
    
    for i = 1:N
        ti = t(i);
        if i == 1
            x(i) = x0;
        else
            tau = 0:dt:ti;
            Fv = F_rect(tau);
            val = Fv .* exp(-zeta*wn*(ti-tau)) .* sin(wd*(ti-tau));
            forced = trapz(tau, val)/(m*wd);
            x(i) = free(ti) + forced;
        end
    end
    
    subplot(3,1,idx);
    plot(t, x, 'LineWidth',1.5,'Color','#0072BD');
    grid on;
    xlabel('Time (t)');
    ylabel('Displacement (x)');
    title([dt_labels{idx} ]);
    xlim([0 t_end]);
    ylim([-1 1]);
end
sgtitle('Rectangular Pulse Response (Different Δt)');

%% Triangular Pulse
figure('Name','Triangular Pulse','Color','w');
for idx = 1:length(dt_list)
    dt = dt_list(idx);
    t = 0:dt:t_end;
    N = length(t);
    x = zeros(1,N);
    
    for i = 1:N
        ti = t(i);
        if i == 1
            x(i) = x0;
        else
            tau = 0:dt:ti;
            Fv = F_tri(tau);
            val = Fv .* exp(-zeta*wn*(ti-tau)) .* sin(wd*(ti-tau));
            forced = trapz(tau, val)/(m*wd);
            x(i) = free(ti) + forced;
        end
    end
    
    subplot(3,1,idx);
    plot(t, x, 'LineWidth',1.5,'Color','#0072BD');
    grid on;
    xlabel('Time (t)');
    ylabel('Displacement (x)');
    title([dt_labels{idx} ]);
    xlim([0 t_end]);
    ylim([-1 1]);
end
sgtitle('Triangular Pulse Response (Different Δt)');