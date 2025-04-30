clc 
close all
clear all
tic;

load('amax_sigma_hopt_epsilon_bmax1_theta5.mat');


epsilon=[0.02, 0.03, 0.04, 0.05];
h_opt=[0.25, 0.5, 0.75, 1];
amax_end=1;
sigma_end=8;

amax=0:0.01:amax_end;
sigma=2:0.02:sigma_end;

m1=length(amax);
m2=length(sigma);

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
[X, Y] = meshgrid(amax, sigma);


for p1=1:length(h_opt)
subplot(1,length(h_opt),p1)
% Crear y mostrar los contornos para cada valor en b
for p2 = 1:length(epsilon)
    [~, h] = contourf(X, Y, R{p1,p2}, contourLevels, 'LineStyle', 'none');
    view(3)
    colormap(color_map_pastel); % Utiliza color_map_pastel
    h.ContourZLevel = epsilon(p2);
    xlabel({'$a_{max}$'}, 'Interpreter', 'latex', 'FontSize', 20);
    ylabel({'$\sigma$'}, 'Interpreter', 'latex', 'FontSize', 20);
    zlabel({'$\epsilon$'},'Interpreter','latex','FontSize', 20);
    set(gca, 'TickLabelInterpreter', 'latex', 'Fontsize', 18);
    xlim([0, 1]); % Establece los límites en el eje x
    ylim([2, 8]); % Establece los límites en el eje y
    xticks([0, 0.5, 1]);
    yticks([2, 4, 6, 8]);
    zticks([0.02, 0.03, 0.04, 0.05]);
    hold on; % Mantener el gráfico actual para superponer los siguientes contornos
end
end

view(60,15)