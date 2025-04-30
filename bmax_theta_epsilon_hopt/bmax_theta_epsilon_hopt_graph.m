clc 
close all
clear all
tic;

load('R_bmax_theta_epsilon_hopt.mat');


epsilon=[0.02, 0.03, 0.04, 0.05];
h_opt=[0.25, 0.5, 0.75, 1];
bmax_end=1;
theta_end=8;

bmax=0:0.01:bmax_end;
theta=2:0.01:theta_end;

m1=length(bmax);
m2=length(theta);

% Crear la figura
figure(1)

% Define la matriz de colores
color_map_pastel = [255, 102, 102;   % Rojo para 0
                    102, 178, 255;   % Azul para 1
                    153, 255, 153;   % Verde para 2
                    255, 255, 102];  % Amarillo para 3

color_map_pastel = color_map_pastel / 255; % Normalizar los valores a [0, 1]

% Asigna la paleta de colores personalizada
colormap(color_map_pastel);

contourLevels = [0, 1, 2, 3]; % Para tus datos discretos de 0 a 3

%Crear la cuadrícula de datos
[X, Y] = meshgrid(bmax, theta);

for p1=1:length(h_opt)
subplot(1,length(h_opt),p1)
% Crear y mostrar los contornos para cada valor en b
for p2 = 1:length(epsilon)
    [~, h] = contourf(X, Y, R{p1,p2}, contourLevels, 'LineStyle', 'none');
    view(3)
    colormap(color_map_pastel); % Utiliza color_map_pastel
    h.ContourZLevel = epsilon(p2);
    xlabel({'$b_{max}$'}, 'Interpreter', 'latex', 'FontSize', 24);
    ylabel({'$\theta$'}, 'Interpreter', 'latex', 'FontSize', 24);
    zlabel({'$\epsilon$'},'Interpreter','latex','FontSize', 24);
    set(gca, 'TickLabelInterpreter', 'latex', 'Fontsize', 20);
    xlim([0, 1]);
    ylim([2, 8]); 
    xticks([0, 0.5, 1]);
    yticks([2, 4, 6, 8]);
    zticks([0.02, 0.03, 0.04, 0.05]);
    hold on; 
end
end

view(60,15)