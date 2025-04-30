clc 
close all
clear all
tic;

load('R1_amax_sigma_greenregion_bmax05_theta5.mat');
load('R2_amax_sigma_yellowregion_bmax09_theta5.mat');
load('R3_amax_sigma_blueregion_bmax025_theta5.mat');





amax_end=1;
sigma_end=6;

amax=0:0.01:amax_end;
sigma=2:0.02:sigma_end;

m1=length(amax);
m2=length(sigma);

% Crear la figura
figure(1)

color_map_pastel2 = [102, 178, 255;   % Azul para 1
                    153, 255, 153;   % Verde para 2
                    255, 255, 102];  % Amarillo para 3
color_map_pastel2 = color_map_pastel2 / 255; % Normalizar los valores a [0, 1]

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

figure(1);

contourf(X, Y, R1', 2000, 'LineStyle', 'none');
colormap(color_map_pastel);
ax = gca;
ax.FontSize = 20;
xlim([0, amax_end]);
ylim([2, sigma_end]);
axis square;
xticks([0, 0.5, 1]);
yticks([2, 4, 6]); 
set(gca, 'TickLabelInterpreter', 'latex', 'Fontsize', 20);

figure(2);

contourf(X, Y, R2', 2000, 'LineStyle', 'none');
colormap(color_map_pastel2);
ax = gca;
ax.FontSize = 20;
xlim([0, amax_end]);
ylim([2, sigma_end]);
axis square;
xticks([0, 0.5, 1]);
yticks([2, 4, 6]); 
set(gca, 'TickLabelInterpreter', 'latex', 'Fontsize', 20)

figure(3);

contourf(X, Y, R3', 2000, 'LineStyle', 'none');
colormap(color_map_pastel2);
ax = gca;
ax.FontSize = 20;
xlim([0, amax_end]);
ylim([2, sigma_end]);
axis square;
xticks([0, 0.5, 1]);
yticks([2, 4, 6]); 
set(gca, 'TickLabelInterpreter', 'latex', 'Fontsize', 20)
